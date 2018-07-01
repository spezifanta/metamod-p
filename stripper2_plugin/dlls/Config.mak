MODNAME = stripper2_mm

EXTRA_CFLAGS = -fpermissive

INCLUDEDIRS+= -I../../hlsdk/common -I../../hlsdk/engine -I../../metamod

SRCFILES = config.cpp dllapi.cpp h_export.cpp sdk_util.cpp stripper2_api.cpp
