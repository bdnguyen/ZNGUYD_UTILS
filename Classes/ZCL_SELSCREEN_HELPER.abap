CLASS zcl_selscreen_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS group_params_to_struct IMPORTING im_cprog         TYPE cprog DEFAULT 'sy-cprog'
                                   EXPORTING VALUE(ex_params) TYPE ANY TABLE.

  PROTECTED SECTION.

  PRIVATE SECTION.

    TYPES: BEGIN OF ty_struct,
             row_name TYPE string,
             row_type TYPE string,
           END OF ty_struct.
    DATA gt_rsscr TYPE TABLE OF rsscr.
    DATA gs_rsscr TYPE rsscr.
    DATA elm_name TYPE string.
    DATA r_type_struct TYPE REF TO cl_abap_structdescr.
*    DATA ref_tabletype TYPE REF TO cl_abap_tabledescr.

ENDCLASS.

CLASS zcl_selscreen_helper IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SELSCREEN_HELPER->GROUP_PARAMS_TO_STRUCT
* +-------------------------------------------------------------------------------------------------+
* | [--->] IM_CPROG                       TYPE        CPROG (default ='sy-cprog')
* | [<---] EX_PARAMS                      TYPE        ANY TABLE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD group_params_to_struct.
    DATA lt_struct TYPE TABLE OF ty_struct.
    DATA ls_struct TYPE ty_struct.

    LOAD REPORT sy-cprog PART 'SSCR' INTO gt_rsscr.
    DELETE gt_rsscr WHERE kind <> 'S' AND kind <> 'P'.
    CHECK lines( gt_rsscr ) > 0.
    LOOP AT gt_rsscr INTO gs_rsscr.
      elm_name = SWITCH #( gs_rsscr-kind
                           WHEN 'S' THEN |{ gs_rsscr-name }[]|
                           WHEN 'P' THEN gs_rsscr-name
                         ).
      DATA(elm_type) = gs_rsscr-dbfield.
      ls_struct-row_name = elm_name.
      ls_struct-row_type = elm_type.
      APPEND ls_struct TO lt_struct.
      CLEAR ls_struct.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
