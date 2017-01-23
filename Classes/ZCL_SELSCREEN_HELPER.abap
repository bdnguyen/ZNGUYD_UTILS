CLASS zcl_selscreen_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_struct,
             row_name TYPE string,
             row_type TYPE string,
           END OF ty_struct.
    TYPES t_out TYPE STANDARD TABLE OF ty_struct WITH DEFAULT KEY.

    METHODS group_params_to_itab IMPORTING im_cprog         TYPE cprog DEFAULT 'sy-cprog'
                                 RETURNING VALUE(rt_params) TYPE t_out.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA gt_rsscr TYPE TABLE OF rsscr WITH DEFAULT KEY. " Structure of itab %_SSCR (selection screen,ABAP/4)
    DATA elm_name TYPE string.

ENDCLASS.



CLASS ZCL_SELSCREEN_HELPER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SELSCREEN_HELPER->GROUP_PARAMS_TO_ITAB
* +-------------------------------------------------------------------------------------------------+
* | [--->] IM_CPROG                       TYPE        CPROG (default ='sy-cprog')
* | [<-()] RT_PARAMS                      TYPE        T_OUT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD group_params_to_itab.
    DATA ls_struct TYPE ty_struct.

    LOAD REPORT sy-cprog PART 'SSCR' INTO gt_rsscr.
    DELETE gt_rsscr WHERE kind <> 'S' AND kind <> 'P'. " Take only select-options and parameters
    CHECK lines( gt_rsscr ) > 0.
    LOOP AT gt_rsscr ASSIGNING FIELD-SYMBOL(<gs_rsscr>).
      elm_name = SWITCH #( <gs_rsscr>-kind
                           WHEN 'S' THEN |{ <gs_rsscr>-name }[]|
                           WHEN 'P' THEN <gs_rsscr>-name
                         ).
      DATA(elm_type) = <gs_rsscr>-dbfield.
      ls_struct-row_name = elm_name.
      ls_struct-row_type = elm_type.
      APPEND ls_struct TO rt_params.
      CLEAR ls_struct.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.