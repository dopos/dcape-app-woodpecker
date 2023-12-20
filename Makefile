## woodpecker Makefile.
## Used with dcape at ../../
#:

SHELL                   = /bin/bash
CFG                    ?= .env

# Docker image version tested for actual dcape release
CICD_VER0              ?= v2.0.0-alpine

#- ******************************************************************************
#- CICD: general config

#- CICD hostname
CICD_HOST              ?= cicd.$(DCAPE_DOMAIN)

#- CICD admin user
CICD_ADMIN             ?= $(DCAPE_ADMIN_USER)

#- VCS (Version control systems) (gitea/github) config

#- Use GitHub
CICD_GITHUB_USED       ?= false
#- Github URL for auth and repos
CICD_GITHUB_URL        ?= http://git.dev.test
#- Github client ID
CICD_GITHUB_CLIENT_ID  ?= SET_GITHUB_CLIENT_ID_HERE
#- Github client secret
CICD_GITHUB_CLIENT_KEY ?= SET_GITHUB_CLIENT_SECRET_HERE

#- Use Gitea
CICD_GITEA_USED        ?= true
#- Gitea URL for auth and repos
CICD_GITEA_URL         ?= $(AUTH_URL)
#- Gitea client ID
CICD_GITEA_CLIENT_ID   ?= $(DRONE_CLIENT_ID)
CICD_GITEA_CLIENT_ID   ?= SET_GITEA_CLIENT_ID_HERE
#- Gitea client secret
CICD_GITEA_CLIENT_KEY  ?= $(DRONE_CLIENT_KEY)
CICD_GITEA_CLIENT_KEY  ?= SET_GITEA_CLIENT_SECRET_HERE

#- ------------------------------------------------------------------------------
#- CICD: internal config

#- Database name and database user name
CICD_DB_TAG            ?= cicd
#- Database user password
CICD_DB_PASS           ?= $(shell openssl rand -hex 16; echo)

#- Agent secret
CICD_AGENT_SECRET      ?= $(shell openssl rand -hex 32; echo)

#- Docker repo & image name without version
CICD_IMAGE             ?= woodpeckerci/woodpecker-server
#- Docker image version
CICD_VER               ?= $(CICD_VER0)

#- dcape root directory
DCAPE_ROOT             ?= $(DCAPE_ROOT)

# Vars for db-create
NAME                    = CICD
DB_INIT_SQL             =

# ------------------------------------------------------------------------------

-include $(CFG)
export

ifdef DCAPE_STACK
include $(DCAPE_ROOT)/Makefile.dcape
else
include $(DCAPE_ROOT)/Makefile.app
endif

# ------------------------------------------------------------------------------

# check app version
init:
	@if [[ "$$CICD_VER0" != "$$CICD_VER" ]] ; then \
	  echo "Warning: CICD_VER in dcape ($$CICD_VER0) differs from yours ($$CICD_VER)" ; \
	fi
	@echo "  URL: $(DCAPE_SCHEME)://$(CICD_HOST)"
	@echo "  Admin: $(CICD_ADMIN)"

ifeq ($(AUTH_TOKEN),)
  ifneq ($(findstring $(MAKECMDGOALS),.setup-before-up oauth2-create),)
    -include $(DCAPE_VAR)/oauth2-token
  endif
endif

# setup app
.setup-before-up: db-create oauth2-create

# create OAuth application credentials
oauth2-create:
	$(MAKE) -s oauth2-app-create HOST=$(CICD_HOST) URL=/authorize PREFIX=CICD_GITEA
