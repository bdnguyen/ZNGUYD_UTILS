CLASS zcl_director DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS construct
      CHANGING
        co_builder TYPE REF TO zcl_abs_job_builder.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_director IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DIRECTOR->CONSTRUCT
* +-------------------------------------------------------------------------------------------------+
* | [<-->] CO_BUILDER                     TYPE REF TO ZCL_ABS_JOB_BUILDER
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD construct.
    co_builder->build_reader( ).
    co_builder->build_generator( ).
    co_builder->build_flusher( ).
  ENDMETHOD.

ENDCLASS.
