/**
 * Compiler implementation of the
 * $(LINK2 http://www.dlang.org, D programming language).
 *
 * Copyright:   Copyright (C) 1994-1998 by Symantec
 *              Copyright (C) 2000-2021 by The D Language Foundation, All Rights Reserved
 * Authors:     $(LINK2 http://www.digitalmars.com, Walter Bright)
 * License:     $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
 * Source:      https://github.com/dlang/dmd/blob/master/src/dmd/backend/_rtlsym.d
 * Documentation: https://dlang.org/phobos/dmd_backend_rtlsym.html
 */

module dmd.backend.rtlsym;

import dmd.backend.cc : Symbol;

enum
{
    RTLSYM_THROW,
    RTLSYM_THROWC,
    RTLSYM_THROWDWARF,
    RTLSYM_MONITOR_HANDLER,
    RTLSYM_MONITOR_PROLOG,
    RTLSYM_MONITOR_EPILOG,
    RTLSYM_DCOVER,
    RTLSYM_DCOVER2,
    RTLSYM_DASSERT,
    RTLSYM_DASSERTP,
    RTLSYM_DASSERT_MSG,
    RTLSYM_DUNITTEST,
    RTLSYM_DUNITTESTP,
    RTLSYM_DUNITTEST_MSG,
    RTLSYM_DARRAY,
    RTLSYM_DARRAYP,
    RTLSYM_DINVARIANT,
    RTLSYM_MEMCPY,
    RTLSYM_MEMSET8,
    RTLSYM_MEMSET16,
    RTLSYM_MEMSET32,
    RTLSYM_MEMSET64,
    RTLSYM_MEMSET128,
    RTLSYM_MEMSET128ii,
    RTLSYM_MEMSET80,
    RTLSYM_MEMSET160,
    RTLSYM_MEMSETFLOAT,
    RTLSYM_MEMSETDOUBLE,
    RTLSYM_MEMSETSIMD,
    RTLSYM_MEMSETN,
    RTLSYM_MODULO,
    RTLSYM_MONITORENTER,
    RTLSYM_MONITOREXIT,
    RTLSYM_CRITICALENTER,
    RTLSYM_CRITICALEXIT,
    RTLSYM_SWITCH_STRING,       // unused
    RTLSYM_SWITCH_USTRING,      // unused
    RTLSYM_SWITCH_DSTRING,      // unused
    RTLSYM_DSWITCHERR,
    RTLSYM_DHIDDENFUNC,
    RTLSYM_NEWCLASS,
    RTLSYM_NEWTHROW,
    RTLSYM_NEWARRAYT,
    RTLSYM_NEWARRAYIT,
    RTLSYM_NEWITEMT,
    RTLSYM_NEWITEMIT,
    RTLSYM_NEWARRAYMT,
    RTLSYM_NEWARRAYMIT,
    RTLSYM_NEWARRAYMTX,
    RTLSYM_NEWARRAYMITX,
    RTLSYM_ARRAYLITERALT,
    RTLSYM_ARRAYLITERALTX,
    RTLSYM_ASSOCARRAYLITERALT,
    RTLSYM_ASSOCARRAYLITERALTX,
    RTLSYM_CALLFINALIZER,
    RTLSYM_CALLINTERFACEFINALIZER,
    RTLSYM_DELCLASS,
    RTLSYM_DELINTERFACE,
    RTLSYM_DELSTRUCT,
    RTLSYM_ALLOCMEMORY,
    RTLSYM_DELARRAY,
    RTLSYM_DELARRAYT,
    RTLSYM_DELMEMORY,
    RTLSYM_INTERFACE,
    RTLSYM_DYNAMIC_CAST,
    RTLSYM_INTERFACE_CAST,
    RTLSYM_FATEXIT,
    RTLSYM_ARRAYCATT,
    RTLSYM_ARRAYCATNT,
    RTLSYM_ARRAYCATNTX,
    RTLSYM_ARRAYAPPENDT,
    RTLSYM_ARRAYAPPENDCT,
    RTLSYM_ARRAYAPPENDCTX,
    RTLSYM_ARRAYAPPENDCD,
    RTLSYM_ARRAYAPPENDWD,
    RTLSYM_ARRAYSETLENGTHT,
    RTLSYM_ARRAYSETLENGTHIT,
    RTLSYM_ARRAYCOPY,
    RTLSYM_ARRAYASSIGN,
    RTLSYM_ARRAYASSIGN_R,
    RTLSYM_ARRAYASSIGN_L,
    RTLSYM_ARRAYCTOR,
    RTLSYM_ARRAYSETASSIGN,
    RTLSYM_ARRAYSETCTOR,
    RTLSYM_ARRAYCAST,
    RTLSYM_ARRAYEQ,
    RTLSYM_ARRAYEQ2,
    RTLSYM_ARRAYCMP,            // unused
    RTLSYM_ARRAYCMP2,           // unused
    RTLSYM_ARRAYCMPCHAR,        // unused
    RTLSYM_OBJ_EQ,              // unused
    RTLSYM_OBJ_CMP,             // unused

    RTLSYM_EXCEPT_HANDLER2,
    RTLSYM_EXCEPT_HANDLER3,
    RTLSYM_CPP_HANDLER,
    RTLSYM_D_HANDLER,
    RTLSYM_D_LOCAL_UNWIND2,
    RTLSYM_LOCAL_UNWIND2,
    RTLSYM_UNWIND_RESUME,
    RTLSYM_PERSONALITY,
    RTLSYM_BEGIN_CATCH,
    RTLSYM_CXA_BEGIN_CATCH,
    RTLSYM_CXA_END_CATCH,

    RTLSYM_TLS_INDEX,
    RTLSYM_TLS_ARRAY,
    RTLSYM_AHSHIFT,

    RTLSYM_HDIFFN,
    RTLSYM_HDIFFF,
    RTLSYM_INTONLY,

    RTLSYM_EXCEPT_LIST,
    RTLSYM_SETJMP3,
    RTLSYM_LONGJMP,
    RTLSYM_ALLOCA,
    RTLSYM_CPP_LONGJMP,
    RTLSYM_PTRCHK,
    RTLSYM_CHKSTK,
    RTLSYM_TRACE_PRO_N,
    RTLSYM_TRACE_PRO_F,
    RTLSYM_TRACE_EPI_N,
    RTLSYM_TRACE_EPI_F,
    RTLSYM_TRACE_CPRO,
    RTLSYM_TRACE_CEPI,

    RTLSYM_TRACENEWCLASS,
    RTLSYM_TRACENEWARRAYT,
    RTLSYM_TRACENEWARRAYIT,
    RTLSYM_TRACENEWARRAYMTX,
    RTLSYM_TRACENEWARRAYMITX,
    RTLSYM_TRACENEWITEMT,
    RTLSYM_TRACENEWITEMIT,
    RTLSYM_TRACECALLFINALIZER,
    RTLSYM_TRACECALLINTERFACEFINALIZER,
    RTLSYM_TRACEDELCLASS,
    RTLSYM_TRACEDELINTERFACE,
    RTLSYM_TRACEDELSTRUCT,
    RTLSYM_TRACEDELARRAYT,
    RTLSYM_TRACEDELMEMORY,
    RTLSYM_TRACEARRAYLITERALTX,
    RTLSYM_TRACEASSOCARRAYLITERALTX,
    RTLSYM_TRACEARRAYCATT,
    RTLSYM_TRACEARRAYCATNTX,
    RTLSYM_TRACEARRAYAPPENDT,
    RTLSYM_TRACEARRAYAPPENDCTX,
    RTLSYM_TRACEARRAYAPPENDCD,
    RTLSYM_TRACEARRAYAPPENDWD,
    RTLSYM_TRACEARRAYSETLENGTHT,
    RTLSYM_TRACEARRAYSETLENGTHIT,
    RTLSYM_TRACEALLOCMEMORY,

    RTLSYM_C_ASSERT,
    RTLSYM_C__ASSERT,
    RTLSYM_C__ASSERT_RTN,

    RTLSYM_MAX
}

extern (C++):

nothrow:
@safe:

Symbol *getRtlsym(int i);
Symbol *getRtlsymPersonality();
