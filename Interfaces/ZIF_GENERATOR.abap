INTERFACE zif_generator
  PUBLIC .

  METHODS generate
    IMPORTING ir_data_itab   TYPE REF TO data
    RETURNING VALUE(rr_itab) TYPE REF TO data.

ENDINTERFACE.
