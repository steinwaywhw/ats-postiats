<?php
/*
**
** The PHP code is generated by atscc2php
** The starting compilation time is: 2016-12-19:  0h:23m
**
*/
function
_ats2phppre_intrange_patsfun_7__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_7($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_9__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_9($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_11__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_11($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_14__closurerize($env0, $env1)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_14($cenv[1], $cenv[2], $arg0); }, $env0, $env1);
}

function
_ats2phppre_intrange_patsfun_18__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_18($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_21__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_21($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_24__closurerize($env0, $env1, $env2)
{
  return array(function($cenv) { return _ats2phppre_intrange_patsfun_24($cenv[1], $cenv[2], $cenv[3]); }, $env0, $env1, $env2);
}

function
_ats2phppre_intrange_patsfun_26__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_26($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_29__closurerize($env0, $env1, $env2)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_29($cenv[1], $cenv[2], $cenv[3], $arg0); }, $env0, $env1, $env2);
}

function
_ats2phppre_intrange_patsfun_31__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_31($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_38__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_38($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_42__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_42($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_46__closurerize($env0)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_46($cenv[1], $arg0); }, $env0);
}

function
_ats2phppre_intrange_patsfun_50__closurerize($env0, $env1, $env2)
{
  return array(function($cenv, $arg0) { return _ats2phppre_intrange_patsfun_50($cenv[1], $cenv[2], $cenv[3], $arg0); }, $env0, $env1, $env2);
}


function
ats2phppre_int_repeat_lazy($arg0, $arg1)
{
//
  $tmp1 = NULL;
//
  __patsflab_int_repeat_lazy:
  $tmp1 = ats2phppre_lazy2cloref($arg1);
  ats2phppre_int_repeat_cloref($arg0, $tmp1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_repeat_cloref($arg0, $arg1)
{
//
//
  __patsflab_int_repeat_cloref:
  _ats2phppre_intrange_loop_2($arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_intrange_loop_2($arg0, $arg1)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $tmp4 = NULL;
  $tmp6 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_2:
  $tmp4 = ats2phppre_gt_int0_int0($arg0, 0);
  if($tmp4) {
    $arg1[0]($arg1);
    $tmp6 = ats2phppre_sub_int0_int0($arg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp6;
    $apy1 = $arg1;
    $arg0 = $apy0;
    $arg1 = $apy1;
    goto __patsflab__ats2phppre_intrange_loop_2;
    // ATStailcalseq_end
  } else {
    // ATSINSmove_void;
  } // endif
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_exists_cloref($arg0, $arg1)
{
//
  $tmpret7 = NULL;
//
  __patsflab_int_exists_cloref:
  $tmpret7 = ats2phppre_intrange_exists_cloref(0, $arg0, $arg1);
  return $tmpret7;
} // end-of-function


function
ats2phppre_int_forall_cloref($arg0, $arg1)
{
//
  $tmpret8 = NULL;
//
  __patsflab_int_forall_cloref:
  $tmpret8 = ats2phppre_intrange_forall_cloref(0, $arg0, $arg1);
  return $tmpret8;
} // end-of-function


function
ats2phppre_int_foreach_cloref($arg0, $arg1)
{
//
//
  __patsflab_int_foreach_cloref:
  ats2phppre_intrange_foreach_cloref(0, $arg0, $arg1);
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_exists_method($arg0)
{
//
  $tmpret10 = NULL;
//
  __patsflab_int_exists_method:
  $tmpret10 = _ats2phppre_intrange_patsfun_7__closurerize($arg0);
  return $tmpret10;
} // end-of-function


function
_ats2phppre_intrange_patsfun_7($env0, $arg0)
{
//
  $tmpret11 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_7:
  $tmpret11 = ats2phppre_int_exists_cloref($env0, $arg0);
  return $tmpret11;
} // end-of-function


function
ats2phppre_int_forall_method($arg0)
{
//
  $tmpret12 = NULL;
//
  __patsflab_int_forall_method:
  $tmpret12 = _ats2phppre_intrange_patsfun_9__closurerize($arg0);
  return $tmpret12;
} // end-of-function


function
_ats2phppre_intrange_patsfun_9($env0, $arg0)
{
//
  $tmpret13 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_9:
  $tmpret13 = ats2phppre_int_forall_cloref($env0, $arg0);
  return $tmpret13;
} // end-of-function


function
ats2phppre_int_foreach_method($arg0)
{
//
  $tmpret14 = NULL;
//
  __patsflab_int_foreach_method:
  $tmpret14 = _ats2phppre_intrange_patsfun_11__closurerize($arg0);
  return $tmpret14;
} // end-of-function


function
_ats2phppre_intrange_patsfun_11($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_intrange_patsfun_11:
  ats2phppre_int_foreach_cloref($env0, $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_int_foldleft_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret16 = NULL;
//
  __patsflab_int_foldleft_cloref:
  $tmpret16 = ats2phppre_intrange_foldleft_cloref(0, $arg0, $arg1, $arg2);
  return $tmpret16;
} // end-of-function


function
ats2phppre_int_foldleft_method($arg0, $arg1)
{
//
  $tmpret17 = NULL;
//
  __patsflab_int_foldleft_method:
  $tmpret17 = _ats2phppre_intrange_patsfun_14__closurerize($arg0, $arg1);
  return $tmpret17;
} // end-of-function


function
_ats2phppre_intrange_patsfun_14($env0, $env1, $arg0)
{
//
  $tmpret18 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_14:
  $tmpret18 = ats2phppre_int_foldleft_cloref($env0, $env1, $arg0);
  return $tmpret18;
} // end-of-function


function
ats2phppre_int_list_map_cloref($arg0, $arg1)
{
//
  $tmpret19 = NULL;
//
  __patsflab_int_list_map_cloref:
  $tmpret19 = _ats2phppre_intrange_aux_16($arg0, $arg1, 0);
  return $tmpret19;
} // end-of-function


function
_ats2phppre_intrange_aux_16($env0, $env1, $arg0)
{
//
  $tmpret20 = NULL;
  $tmp21 = NULL;
  $tmp22 = NULL;
  $tmp23 = NULL;
  $tmp24 = NULL;
//
  __patsflab__ats2phppre_intrange_aux_16:
  $tmp21 = ats2phppre_lt_int1_int1($arg0, $env0);
  if($tmp21) {
    $tmp22 = $env1[0]($env1, $arg0);
    $tmp24 = ats2phppre_add_int1_int1($arg0, 1);
    $tmp23 = _ats2phppre_intrange_aux_16($env0, $env1, $tmp24);
    $tmpret20 = array($tmp22, $tmp23);
  } else {
    $tmpret20 = NULL;
  } // endif
  return $tmpret20;
} // end-of-function


function
ats2phppre_int_list_map_method($arg0, $arg1)
{
//
  $tmpret25 = NULL;
//
  __patsflab_int_list_map_method:
  $tmpret25 = _ats2phppre_intrange_patsfun_18__closurerize($arg0);
  return $tmpret25;
} // end-of-function


function
_ats2phppre_intrange_patsfun_18($env0, $arg0)
{
//
  $tmpret26 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_18:
  $tmpret26 = ats2phppre_int_list_map_cloref($env0, $arg0);
  return $tmpret26;
} // end-of-function


function
ats2phppre_int_list0_map_cloref($arg0, $arg1)
{
//
  $tmpret27 = NULL;
  $tmp28 = NULL;
  $tmp29 = NULL;
//
  __patsflab_int_list0_map_cloref:
  $tmp28 = ats2phppre_gte_int1_int1($arg0, 0);
  if($tmp28) {
    $tmp29 = ats2phppre_int_list_map_cloref($arg0, $arg1);
    $tmpret27 = $tmp29;
  } else {
    $tmpret27 = NULL;
  } // endif
  return $tmpret27;
} // end-of-function


function
ats2phppre_int_list0_map_method($arg0, $arg1)
{
//
  $tmpret30 = NULL;
//
  __patsflab_int_list0_map_method:
  $tmpret30 = _ats2phppre_intrange_patsfun_21__closurerize($arg0);
  return $tmpret30;
} // end-of-function


function
_ats2phppre_intrange_patsfun_21($env0, $arg0)
{
//
  $tmpret31 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_21:
  $tmpret31 = ats2phppre_int_list0_map_cloref($env0, $arg0);
  return $tmpret31;
} // end-of-function


function
ats2phppre_int_stream_map_cloref($arg0, $arg1)
{
//
  $tmpret32 = NULL;
//
  __patsflab_int_stream_map_cloref:
  $tmpret32 = _ats2phppre_intrange_aux_23($arg0, $arg1, 0);
  return $tmpret32;
} // end-of-function


function
_ats2phppre_intrange_aux_23($env0, $env1, $arg0)
{
//
  $tmpret33 = NULL;
//
  __patsflab__ats2phppre_intrange_aux_23:
  $tmpret33 = ATSPMVlazyval(_ats2phppre_intrange_patsfun_24__closurerize($env0, $env1, $arg0));
  return $tmpret33;
} // end-of-function


function
_ats2phppre_intrange_patsfun_24($env0, $env1, $env2)
{
//
  $tmpret34 = NULL;
  $tmp35 = NULL;
  $tmp36 = NULL;
  $tmp37 = NULL;
  $tmp38 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_24:
  $tmp35 = ats2phppre_lt_int1_int1($env2, $env0);
  if($tmp35) {
    $tmp36 = $env1[0]($env1, $env2);
    $tmp38 = ats2phppre_add_int1_int1($env2, 1);
    $tmp37 = _ats2phppre_intrange_aux_23($env0, $env1, $tmp38);
    $tmpret34 = array($tmp36, $tmp37);
  } else {
    $tmpret34 = NULL;
  } // endif
  return $tmpret34;
} // end-of-function


function
ats2phppre_int_stream_map_method($arg0, $arg1)
{
//
  $tmpret39 = NULL;
//
  __patsflab_int_stream_map_method:
  $tmpret39 = _ats2phppre_intrange_patsfun_26__closurerize($arg0);
  return $tmpret39;
} // end-of-function


function
_ats2phppre_intrange_patsfun_26($env0, $arg0)
{
//
  $tmpret40 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_26:
  $tmpret40 = ats2phppre_int_stream_map_cloref($env0, $arg0);
  return $tmpret40;
} // end-of-function


function
ats2phppre_int_stream_vt_map_cloref($arg0, $arg1)
{
//
  $tmpret41 = NULL;
//
  __patsflab_int_stream_vt_map_cloref:
  $tmpret41 = _ats2phppre_intrange_aux_28($arg0, $arg1, 0);
  return $tmpret41;
} // end-of-function


function
_ats2phppre_intrange_aux_28($env0, $env1, $arg0)
{
//
  $tmpret42 = NULL;
//
  __patsflab__ats2phppre_intrange_aux_28:
  $tmpret42 = ATSPMVllazyval(_ats2phppre_intrange_patsfun_29__closurerize($env0, $env1, $arg0));
  return $tmpret42;
} // end-of-function


function
_ats2phppre_intrange_patsfun_29($env0, $env1, $env2, $arg0)
{
//
  $tmpret43 = NULL;
  $tmp44 = NULL;
  $tmp45 = NULL;
  $tmp46 = NULL;
  $tmp47 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_29:
  if($arg0) {
    $tmp44 = ats2phppre_lt_int1_int1($env2, $env0);
    if($tmp44) {
      $tmp45 = $env1[0]($env1, $env2);
      $tmp47 = ats2phppre_add_int1_int1($env2, 1);
      $tmp46 = _ats2phppre_intrange_aux_28($env0, $env1, $tmp47);
      $tmpret43 = array($tmp45, $tmp46);
    } else {
      $tmpret43 = NULL;
    } // endif
  } else {
  } // endif
  return $tmpret43;
} // end-of-function


function
ats2phppre_int_stream_vt_map_method($arg0, $arg1)
{
//
  $tmpret48 = NULL;
//
  __patsflab_int_stream_vt_map_method:
  $tmpret48 = _ats2phppre_intrange_patsfun_31__closurerize($arg0);
  return $tmpret48;
} // end-of-function


function
_ats2phppre_intrange_patsfun_31($env0, $arg0)
{
//
  $tmpret49 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_31:
  $tmpret49 = ats2phppre_int_stream_vt_map_cloref($env0, $arg0);
  return $tmpret49;
} // end-of-function


function
ats2phppre_int2_exists_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret50 = NULL;
//
  __patsflab_int2_exists_cloref:
  $tmpret50 = ats2phppre_intrange2_exists_cloref(0, $arg0, 0, $arg1, $arg2);
  return $tmpret50;
} // end-of-function


function
ats2phppre_int2_forall_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret51 = NULL;
//
  __patsflab_int2_forall_cloref:
  $tmpret51 = ats2phppre_intrange2_forall_cloref(0, $arg0, 0, $arg1, $arg2);
  return $tmpret51;
} // end-of-function


function
ats2phppre_int2_foreach_cloref($arg0, $arg1, $arg2)
{
//
//
  __patsflab_int2_foreach_cloref:
  ats2phppre_intrange2_foreach_cloref(0, $arg0, 0, $arg1, $arg2);
  return/*_void*/;
} // end-of-function


function
ats2phppre_intrange_exists_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret53 = NULL;
//
  __patsflab_intrange_exists_cloref:
  $tmpret53 = _ats2phppre_intrange_loop_36($arg0, $arg1, $arg2);
  return $tmpret53;
} // end-of-function


function
_ats2phppre_intrange_loop_36($arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmpret54 = NULL;
  $tmp55 = NULL;
  $tmp56 = NULL;
  $tmp57 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_36:
  $tmp55 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp55) {
    $tmp56 = $arg2[0]($arg2, $arg0);
    if($tmp56) {
      $tmpret54 = true;
    } else {
      $tmp57 = ats2phppre_add_int0_int0($arg0, 1);
      // ATStailcalseq_beg
      $apy0 = $tmp57;
      $apy1 = $arg1;
      $apy2 = $arg2;
      $arg0 = $apy0;
      $arg1 = $apy1;
      $arg2 = $apy2;
      goto __patsflab__ats2phppre_intrange_loop_36;
      // ATStailcalseq_end
    } // endif
  } else {
    $tmpret54 = false;
  } // endif
  return $tmpret54;
} // end-of-function


function
ats2phppre_intrange_exists_method($arg0)
{
//
  $tmpret58 = NULL;
//
  __patsflab_intrange_exists_method:
  $tmpret58 = _ats2phppre_intrange_patsfun_38__closurerize($arg0);
  return $tmpret58;
} // end-of-function


function
_ats2phppre_intrange_patsfun_38($env0, $arg0)
{
//
  $tmpret59 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_38:
  $tmpret59 = ats2phppre_intrange_exists_cloref($env0[0], $env0[1], $arg0);
  return $tmpret59;
} // end-of-function


function
ats2phppre_intrange_forall_cloref($arg0, $arg1, $arg2)
{
//
  $tmpret60 = NULL;
//
  __patsflab_intrange_forall_cloref:
  $tmpret60 = _ats2phppre_intrange_loop_40($arg0, $arg1, $arg2);
  return $tmpret60;
} // end-of-function


function
_ats2phppre_intrange_loop_40($arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmpret61 = NULL;
  $tmp62 = NULL;
  $tmp63 = NULL;
  $tmp64 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_40:
  $tmp62 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp62) {
    $tmp63 = $arg2[0]($arg2, $arg0);
    if($tmp63) {
      $tmp64 = ats2phppre_add_int0_int0($arg0, 1);
      // ATStailcalseq_beg
      $apy0 = $tmp64;
      $apy1 = $arg1;
      $apy2 = $arg2;
      $arg0 = $apy0;
      $arg1 = $apy1;
      $arg2 = $apy2;
      goto __patsflab__ats2phppre_intrange_loop_40;
      // ATStailcalseq_end
    } else {
      $tmpret61 = false;
    } // endif
  } else {
    $tmpret61 = true;
  } // endif
  return $tmpret61;
} // end-of-function


function
ats2phppre_intrange_forall_method($arg0)
{
//
  $tmpret65 = NULL;
//
  __patsflab_intrange_forall_method:
  $tmpret65 = _ats2phppre_intrange_patsfun_42__closurerize($arg0);
  return $tmpret65;
} // end-of-function


function
_ats2phppre_intrange_patsfun_42($env0, $arg0)
{
//
  $tmpret66 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_42:
  $tmpret66 = ats2phppre_intrange_forall_cloref($env0[0], $env0[1], $arg0);
  return $tmpret66;
} // end-of-function


function
ats2phppre_intrange_foreach_cloref($arg0, $arg1, $arg2)
{
//
//
  __patsflab_intrange_foreach_cloref:
  _ats2phppre_intrange_loop_44($arg0, $arg1, $arg2);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_intrange_loop_44($arg0, $arg1, $arg2)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $tmp69 = NULL;
  $tmp71 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_44:
  $tmp69 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp69) {
    $arg2[0]($arg2, $arg0);
    $tmp71 = ats2phppre_add_int0_int0($arg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp71;
    $apy1 = $arg1;
    $apy2 = $arg2;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    goto __patsflab__ats2phppre_intrange_loop_44;
    // ATStailcalseq_end
  } else {
    // ATSINSmove_void;
  } // endif
  return/*_void*/;
} // end-of-function


function
ats2phppre_intrange_foreach_method($arg0)
{
//
  $tmpret72 = NULL;
//
  __patsflab_intrange_foreach_method:
  $tmpret72 = _ats2phppre_intrange_patsfun_46__closurerize($arg0);
  return $tmpret72;
} // end-of-function


function
_ats2phppre_intrange_patsfun_46($env0, $arg0)
{
//
//
  __patsflab__ats2phppre_intrange_patsfun_46:
  ats2phppre_intrange_foreach_cloref($env0[0], $env0[1], $arg0);
  return/*_void*/;
} // end-of-function


function
ats2phppre_intrange_foldleft_cloref($arg0, $arg1, $arg2, $arg3)
{
//
  $tmpret74 = NULL;
//
  __patsflab_intrange_foldleft_cloref:
  $tmpret74 = _ats2phppre_intrange_loop_48($arg3, $arg0, $arg1, $arg2, $arg3);
  return $tmpret74;
} // end-of-function


function
_ats2phppre_intrange_loop_48($env0, $arg0, $arg1, $arg2, $arg3)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $tmpret75 = NULL;
  $tmp76 = NULL;
  $tmp77 = NULL;
  $tmp78 = NULL;
//
  __patsflab__ats2phppre_intrange_loop_48:
  $tmp76 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp76) {
    $tmp77 = ats2phppre_add_int0_int0($arg0, 1);
    $tmp78 = $arg3[0]($arg3, $arg2, $arg0);
    // ATStailcalseq_beg
    $apy0 = $tmp77;
    $apy1 = $arg1;
    $apy2 = $tmp78;
    $apy3 = $env0;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    goto __patsflab__ats2phppre_intrange_loop_48;
    // ATStailcalseq_end
  } else {
    $tmpret75 = $arg2;
  } // endif
  return $tmpret75;
} // end-of-function


function
ats2phppre_intrange_foldleft_method($arg0, $arg1)
{
//
  $tmp79 = NULL;
  $tmp80 = NULL;
  $tmpret81 = NULL;
//
  __patsflab_intrange_foldleft_method:
  $tmp79 = $arg0[0];
  $tmp80 = $arg0[1];
  $tmpret81 = _ats2phppre_intrange_patsfun_50__closurerize($tmp79, $tmp80, $arg1);
  return $tmpret81;
} // end-of-function


function
_ats2phppre_intrange_patsfun_50($env0, $env1, $env2, $arg0)
{
//
  $tmpret82 = NULL;
//
  __patsflab__ats2phppre_intrange_patsfun_50:
  $tmpret82 = ats2phppre_intrange_foldleft_cloref($env0, $env1, $env2, $arg0);
  return $tmpret82;
} // end-of-function


function
ats2phppre_intrange2_exists_cloref($arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $tmpret83 = NULL;
//
  __patsflab_intrange2_exists_cloref:
  $tmpret83 = _ats2phppre_intrange_loop1_52($arg2, $arg3, $arg4, $arg0, $arg1, $arg2, $arg3, $arg4);
  return $tmpret83;
} // end-of-function


function
_ats2phppre_intrange_loop1_52($env0, $env1, $env2, $arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $apy4 = NULL;
  $tmpret84 = NULL;
  $tmp85 = NULL;
  $a2rg0 = NULL;
  $a2rg1 = NULL;
  $a2rg2 = NULL;
  $a2rg3 = NULL;
  $a2rg4 = NULL;
  $a2py0 = NULL;
  $a2py1 = NULL;
  $a2py2 = NULL;
  $a2py3 = NULL;
  $a2py4 = NULL;
  $tmpret86 = NULL;
  $tmp87 = NULL;
  $tmp88 = NULL;
  $tmp89 = NULL;
  $tmp90 = NULL;
//
  __patsflab__ats2phppre_intrange_loop1_52:
  $tmp85 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp85) {
    // ATStailcalseq_beg
    $a2py0 = $arg0;
    $a2py1 = $arg1;
    $a2py2 = $arg2;
    $a2py3 = $arg3;
    $a2py4 = $env2;
    $a2rg0 = $a2py0;
    $a2rg1 = $a2py1;
    $a2rg2 = $a2py2;
    $a2rg3 = $a2py3;
    $a2rg4 = $a2py4;
    goto __patsflab__ats2phppre_intrange_loop2_53;
    // ATStailcalseq_end
  } else {
    $tmpret84 = false;
  } // endif
  return $tmpret84;
//
  __patsflab__ats2phppre_intrange_loop2_53:
  $tmp87 = ats2phppre_lt_int0_int0($a2rg2, $a2rg3);
  if($tmp87) {
    $tmp88 = $a2rg4[0]($a2rg4, $a2rg0, $a2rg2);
    if($tmp88) {
      $tmpret86 = true;
    } else {
      $tmp89 = ats2phppre_add_int0_int0($a2rg2, 1);
      // ATStailcalseq_beg
      $a2py0 = $a2rg0;
      $a2py1 = $a2rg1;
      $a2py2 = $tmp89;
      $a2py3 = $a2rg3;
      $a2py4 = $a2rg4;
      $a2rg0 = $a2py0;
      $a2rg1 = $a2py1;
      $a2rg2 = $a2py2;
      $a2rg3 = $a2py3;
      $a2rg4 = $a2py4;
      goto __patsflab__ats2phppre_intrange_loop2_53;
      // ATStailcalseq_end
    } // endif
  } else {
    $tmp90 = ats2phppre_add_int0_int0($a2rg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp90;
    $apy1 = $a2rg1;
    $apy2 = $env0;
    $apy3 = $env1;
    $apy4 = $a2rg4;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    $arg4 = $apy4;
    goto __patsflab__ats2phppre_intrange_loop1_52;
    // ATStailcalseq_end
  } // endif
  return $tmpret86;
} // end-of-function


function
ats2phppre_intrange2_forall_cloref($arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $tmpret91 = NULL;
//
  __patsflab_intrange2_forall_cloref:
  $tmpret91 = _ats2phppre_intrange_loop1_55($arg2, $arg3, $arg0, $arg1, $arg2, $arg3, $arg4);
  return $tmpret91;
} // end-of-function


function
_ats2phppre_intrange_loop1_55($env0, $env1, $arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $apy4 = NULL;
  $tmpret92 = NULL;
  $tmp93 = NULL;
  $a2rg0 = NULL;
  $a2rg1 = NULL;
  $a2rg2 = NULL;
  $a2rg3 = NULL;
  $a2rg4 = NULL;
  $a2py0 = NULL;
  $a2py1 = NULL;
  $a2py2 = NULL;
  $a2py3 = NULL;
  $a2py4 = NULL;
  $tmpret94 = NULL;
  $tmp95 = NULL;
  $tmp96 = NULL;
  $tmp97 = NULL;
  $tmp98 = NULL;
//
  __patsflab__ats2phppre_intrange_loop1_55:
  $tmp93 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp93) {
    // ATStailcalseq_beg
    $a2py0 = $arg0;
    $a2py1 = $arg1;
    $a2py2 = $arg2;
    $a2py3 = $arg3;
    $a2py4 = $arg4;
    $a2rg0 = $a2py0;
    $a2rg1 = $a2py1;
    $a2rg2 = $a2py2;
    $a2rg3 = $a2py3;
    $a2rg4 = $a2py4;
    goto __patsflab__ats2phppre_intrange_loop2_56;
    // ATStailcalseq_end
  } else {
    $tmpret92 = true;
  } // endif
  return $tmpret92;
//
  __patsflab__ats2phppre_intrange_loop2_56:
  $tmp95 = ats2phppre_lt_int0_int0($a2rg2, $a2rg3);
  if($tmp95) {
    $tmp96 = $a2rg4[0]($a2rg4, $a2rg0, $a2rg2);
    if($tmp96) {
      $tmp97 = ats2phppre_add_int0_int0($a2rg2, 1);
      // ATStailcalseq_beg
      $a2py0 = $a2rg0;
      $a2py1 = $a2rg1;
      $a2py2 = $tmp97;
      $a2py3 = $a2rg3;
      $a2py4 = $a2rg4;
      $a2rg0 = $a2py0;
      $a2rg1 = $a2py1;
      $a2rg2 = $a2py2;
      $a2rg3 = $a2py3;
      $a2rg4 = $a2py4;
      goto __patsflab__ats2phppre_intrange_loop2_56;
      // ATStailcalseq_end
    } else {
      $tmpret94 = false;
    } // endif
  } else {
    $tmp98 = ats2phppre_add_int0_int0($a2rg0, 1);
    // ATStailcalseq_beg
    $apy0 = $tmp98;
    $apy1 = $a2rg1;
    $apy2 = $env0;
    $apy3 = $env1;
    $apy4 = $a2rg4;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    $arg4 = $apy4;
    goto __patsflab__ats2phppre_intrange_loop1_55;
    // ATStailcalseq_end
  } // endif
  return $tmpret94;
} // end-of-function


function
ats2phppre_intrange2_foreach_cloref($arg0, $arg1, $arg2, $arg3, $arg4)
{
//
//
  __patsflab_intrange2_foreach_cloref:
  _ats2phppre_intrange_loop1_58($arg2, $arg3, $arg0, $arg1, $arg2, $arg3, $arg4);
  return/*_void*/;
} // end-of-function


function
_ats2phppre_intrange_loop1_58($env0, $env1, $arg0, $arg1, $arg2, $arg3, $arg4)
{
//
  $apy0 = NULL;
  $apy1 = NULL;
  $apy2 = NULL;
  $apy3 = NULL;
  $apy4 = NULL;
  $tmp101 = NULL;
  $a2rg0 = NULL;
  $a2rg1 = NULL;
  $a2rg2 = NULL;
  $a2rg3 = NULL;
  $a2rg4 = NULL;
  $a2py0 = NULL;
  $a2py1 = NULL;
  $a2py2 = NULL;
  $a2py3 = NULL;
  $a2py4 = NULL;
  $tmp103 = NULL;
  $tmp105 = NULL;
  $tmp106 = NULL;
//
  __patsflab__ats2phppre_intrange_loop1_58:
  $tmp101 = ats2phppre_lt_int0_int0($arg0, $arg1);
  if($tmp101) {
    // ATStailcalseq_beg
    $a2py0 = $arg0;
    $a2py1 = $arg1;
    $a2py2 = $arg2;
    $a2py3 = $arg3;
    $a2py4 = $arg4;
    $a2rg0 = $a2py0;
    $a2rg1 = $a2py1;
    $a2rg2 = $a2py2;
    $a2rg3 = $a2py3;
    $a2rg4 = $a2py4;
    goto __patsflab__ats2phppre_intrange_loop2_59;
    // ATStailcalseq_end
  } else {
    // ATSINSmove_void;
  } // endif
  return/*_void*/;
//
  __patsflab__ats2phppre_intrange_loop2_59:
  $tmp103 = ats2phppre_lt_int0_int0($a2rg2, $a2rg3);
  if($tmp103) {
    $a2rg4[0]($a2rg4, $a2rg0, $a2rg2);
    $tmp105 = ats2phppre_add_int0_int0($a2rg2, 1);
    // ATStailcalseq_beg
    $a2py0 = $a2rg0;
    $a2py1 = $a2rg1;
    $a2py2 = $tmp105;
    $a2py3 = $a2rg3;
    $a2py4 = $a2rg4;
    $a2rg0 = $a2py0;
    $a2rg1 = $a2py1;
    $a2rg2 = $a2py2;
    $a2rg3 = $a2py3;
    $a2rg4 = $a2py4;
    goto __patsflab__ats2phppre_intrange_loop2_59;
    // ATStailcalseq_end
  } else {
    $tmp106 = ats2phppre_succ_int0($a2rg0);
    // ATStailcalseq_beg
    $apy0 = $tmp106;
    $apy1 = $a2rg1;
    $apy2 = $env0;
    $apy3 = $env1;
    $apy4 = $a2rg4;
    $arg0 = $apy0;
    $arg1 = $apy1;
    $arg2 = $apy2;
    $arg3 = $apy3;
    $arg4 = $apy4;
    goto __patsflab__ats2phppre_intrange_loop1_58;
    // ATStailcalseq_end
  } // endif
  return/*_void*/;
} // end-of-function

/* ****** ****** */

/* end-of-compilation-unit */
?>
