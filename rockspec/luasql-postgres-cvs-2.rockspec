package = "LuaSQL-Postgres"
version = "cvs-2"
source = {
  url = "git://github.com/stoni/luasql.git"
}
description = {
   summary = "Database connectivity for Lua (Postgres driver)",
   detailed = [[
      LuaSQL is a simple interface from Lua to a DBMS. It enables a
      Lua program to connect to databases, execute arbitrary SQL statements
      and retrieve results in a row-by-row cursor fashion.
   ]],
   license = "MIT/X11",
   homepage = "http://www.keplerproject.org/luasql/"
}
dependencies = {
   "lua >= 5.1"
}
external_dependencies = {
   platforms = {
     unix = {
        POSTGRES = {
          header = "pg_config.h",
	  library = "pq"
        }
     },
     win32 = {
        POSTGRES = {
          header = "pg_config.h",
          library = "libpq"
        }
     }
   }
}
build = {
   platforms = {
     unix = {
	   type = "make",
       variables = {
         T="postgres",
         LIB_OPTION = "$(LIBFLAG) -L$(POSTGRES_LIBDIR) -lpq",
         CFLAGS = "$(CFLAGS) -I$(LUA_INCDIR) -I$(POSTGRES_INCDIR) -I$(POSTGRES_INCDIR)/postgresql"
       },
       build_variables = {
        DRIVER_LIBS="",
       },
       install_variables = {
         LUA_LIBDIR = "$(LIBDIR)",
       }   
	 },
	 win32 = {
	    type = "builtin",
		modules = {
         ["luasql.postgres"] = {
           sources = {"src/luasql.c", "src/ls_postgres.c"},
           libraries = {"libpq", "Ws2_32", "crypt32", "dnsapi", "secur32", "advapi32", "shell32"},
	       incdirs = {"$(POSTGRES_INCDIR)"},
           libdirs = {"$(POSTGRES_LIBDIR)"}
        }
      }
	 }
   }
   
}
