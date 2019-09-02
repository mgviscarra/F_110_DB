create database FORM110
go

use FORM110
go

/*==============================================================*/
/* Table: DEPENDIENTE                                           */
/*==============================================================*/
create table DEPENDIENTE (
   DOCUMENTO_IDENTIDAD  int                  not null,
   ID_LUGAR             int                  null,
   NOMBRES              char(256)            not null,
   APELLIDO_PATERNO     char(256)            not null,
   APELLIDO_MATERNO     char(256)            not null,
   APELLIDO_CASADA      char(256)            null,
   DOMICILIO            char(256)            not null,
   NUMERO_NIT_EMPLEADOR int                  not null
)
go

/*==============================================================*/
/* Table: EMPLEADOR                                              */
/*==============================================================*/
create table EMPLEADOR (
   NUMERO_NIT           int                  not null,
   RAZON_SOCIAL         char(256)            null,
   DOMICILIO            char(256)            null
)
go

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   NRO_FACTURA          int                  not null,
   NIT                  int                  not null,
   NUMERO_AUTORIZACION  int                  not null,
   FECHA                datetime             not null,
   IMPORTE              float                not null,
   CODIGO_CONTROL       char(256)            null,
   FACTURA_ELECTRONICA  char(256)            null,
   NUMERO_ORDEN_FORMULARIO int                  null
)
go

/*==============================================================*/
/* Table: FORMULARIO_110                                        */
/*==============================================================*/
create table FORMULARIO_110 (
   NUMERO_ORDEN         int                  not null,
   DOCUMENTO_IDENTIDAD  int                  null,
   MES                  int                  null,
   ANO                  int                  null,
   TOTAL_DETALLE        float                null,
   DETERMINACION_PAGO   float                null,
   FECHA_PRESENTACION   datetime             null,
   LUGAR_PRESENTACION   int                  null
)
go

/*==============================================================*/
/* Table: LUGAR                                                 */
/*==============================================================*/
create table LUGAR (
   ID_LUGAR             int                  not null,
   LUGAR                char(256)            null
)
go

alter table DEPENDIENTE
   add constraint PK_DEPENDIENTE primary key nonclustered (DOCUMENTO_IDENTIDAD)
go

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on DEPENDIENTE (
ID_LUGAR ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on DEPENDIENTE (
NUMERO_NIT_EMPLEADOR ASC
)
go

alter table EMPLEADOR
   add constraint PK_EMPLEADOR primary key nonclustered (NUMERO_NIT)
go



alter table FACTURA
   add constraint PK_FACTURA primary key nonclustered (NRO_FACTURA)
go

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_3_FK on FACTURA (
NUMERO_ORDEN_FORMULARIO ASC
)
go

alter table FORMULARIO_110
   add constraint PK_FORMULARIO_110 primary key nonclustered (NUMERO_ORDEN)
go

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_4_FK on FORMULARIO_110 (
DOCUMENTO_IDENTIDAD ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_5_FK on FORMULARIO_110 (
LUGAR_PRESENTACION ASC
)
go

alter table LUGAR
   add constraint PK_LUGAR primary key nonclustered (ID_LUGAR)
go

alter table DEPENDIENTE
   add constraint FK_DEPENDIE_RELATIONS_LUGAR foreign key (ID_LUGAR)
      references LUGAR (ID_LUGAR)
go

alter table DEPENDIENTE
   add constraint FK_DEPENDIE_RELATIONS_EMPLEADOR foreign key (NUMERO_NIT_EMPLEADOR)
      references EMPLEADOR (NUMERO_NIT)
go

alter table FACTURA
   add constraint FK_FACTURA_RELATIONS_FORMULAR foreign key (NUMERO_ORDEN_FORMULARIO)
      references FORMULARIO_110 (NUMERO_ORDEN)
go

alter table FORMULARIO_110
   add constraint FK_FORMULAR_RELATIONS_DEPENDIE foreign key (DOCUMENTO_IDENTIDAD)
      references DEPENDIENTE (DOCUMENTO_IDENTIDAD)
go

alter table FORMULARIO_110
   add constraint FK_FORMULAR_RELATIONS_LUGAR foreign key (LUGAR_PRESENTACION)
      references LUGAR (ID_LUGAR)
go
