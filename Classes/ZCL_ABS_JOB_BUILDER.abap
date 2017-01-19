CLASS zcl_abs_job_builder DEFINITION
  PUBLIC ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA:
      go_reader    TYPE REF TO zif_reader,
      go_generator TYPE REF TO zif_generator,
      go_flusher   TYPE REF TO zif_flusher.
    METHODS:
      build_reader ABSTRACT,
      build_generator ABSTRACT,
      build_flusher ABSTRACT.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_abs_job_builder IMPLEMENTATION.
ENDCLASS.
