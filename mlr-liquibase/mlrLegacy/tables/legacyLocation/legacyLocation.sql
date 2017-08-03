create table mlr_legacy_data.legacy_location
(legacy_location_id             bigserial               primary key          
,agency_cd                      character(5)            not null
,site_no                        character(15)           not null
,station_nm                     character varying(50)   not null
,station_ix                     character varying(50)   not null
,lat_va                         character(11)           not null
,long_va                        character(12)           not null
,dec_lat_va                     double precision
,dec_long_va                    double precision
,coord_meth_cd                  character(1)            not null
,coord_acy_cd                   character(1)            not null
,coord_datum_cd                 character(10)           not null
,district_cd                    character(3)            not null
,land_net_ds                    character varying(23)   not null
,map_nm                         character varying(20)   not null
,country_cd                     character(2)            not null
,state_cd                       character(2)            not null
,county_cd                      character(3)            not null
,map_scale_fc                   character(7)            not null
,alt_va                         character(8)            not null
,alt_meth_cd                    character(1)            not null
,alt_acy_va                     character(3)            not null
,alt_datum_cd                   character(10)           not null
,huc_cd                         character varying(16)   not null
,agency_use_cd                  character(1)            not null
,basin_cd                       character(2)            not null
,site_tp_cd                     character varying(7)    not null
,topo_cd                        character(1)            not null
,data_types_cd                  character(30)           not null
,instruments_cd                 character(30)           not null
,site_rmks_tx                   character varying(50)   not null
,inventory_dt                   character(8)            not null
,drain_area_va                  character(8)            not null
,contrib_drain_area_va          character(8)            not null
,tz_cd                          character(6)            not null
,local_time_fg                  character(1)            not null
,gw_file_cd                     character(30)           not null
,construction_dt                character(8)            not null
,reliability_cd                 character(1)            not null
,aqfr_cd                        character(8)            not null
,nat_aqfr_cd                    character(10)           not null default '          '
,site_use_1_cd                  character(1)            not null
,site_use_2_cd                  character(1)            not null
,site_use_3_cd                  character(1)            not null
,water_use_1_cd                 character(1)            not null
,water_use_2_cd                 character(1)            not null
,water_use_3_cd                 character(1)            not null
,nat_water_use_cd               character(2)            not null
,aqfr_type_cd                   character(1)            not null
,well_depth_va                  character(8)            not null
,hole_depth_va                  character(8)            not null
,depth_src_cd                   character(1)            not null
,project_no                     character(12)           not null
,site_web_cd                    character(1)            not null
,site_cn                        character(8)            not null
,site_cr                        date                    not null
,site_mn                        character(8)            not null
,site_md                        date                    not null
,constraint legacy_location_ak
  unique (agency_cd, site_no)
);
alter table mlr_legacy_data.legacy_location owner to mlr_legacy_data;
