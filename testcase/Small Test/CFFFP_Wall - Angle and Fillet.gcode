;FLAVOR:Marlin
;TIME:92
;Filament used: 0.0939765m, 0m
;Layer height: 0.2
;MINX:92.122
;MINY:38.13
;MINZ:0.2
;MAXX:192.874
;MAXY:139.93
;MAXZ:0.4
;TARGET_MACHINE.NAME:Unknown
;Generated with Cura_SteamEngine 5.7.1
T0
M104 S170
M105
M109 S170
M82 ;absolute extrusion mode
M205 X6 Y6; set x and y jerk
M106 S120 ; set fan to 50
M104 S180 ; extruder to 180 c
M82 ;absolute extrusion mode
G21 ;metric values
G90 ;absolute positioning
M82 ;set extruder to absolute mode
G28; home all axis
G29
M109
G1 X-50 Y100 Z10 F7200;
M163 S0 P0.5; set mix ratio for motor 1 to 50
M163 S1 P0.5; set mix ratio for motor 2 to 50
M163 S2 P0;No plastic
M164 S5; set mixing ratio of silicone print head tool 5
M163 S0 P0.5; set mix ratio for motor 1 to 50
M163 S1 P0.5; set mix ratio for motor 2 to 50
M163 S2 P0;No plastic
M164 S6; set mixing ratio of silicone print head tool 6
M163 S0 P0; set mix ratio for motor 1 to 0
M163 S1 P0; set mix ratio for motor 2 to 0
M163 S2 P1;plastic
M164 S4; set mixing ratio of plastic print head tool 4
T4; Set tool to plastic head
G1 X5 Y5 F7200;
G1 Z0.3 F100;
G92 E0; Zero Extruder
G1 X70 E25 F300;
G92 E0; zero exturder
G1 E-.1 F100;
G92 E0; zero extruder
G1 X80 F7200;
G92 E0;
G1 Z30 F200;
G1 G1 X-10 Y100 F7200;
G4 S20; Wait 20 seconds;
G1 Z1 F200;
G92 E0
;////////// Starting silicone //////////
;TYPE:SILICONE-START
G90 ; switch back to absolute mode
G1 X-77 Y45;
T6; Purge silicone tool head
G92 E0 ;Zero extuder
G1 E130 F350;
G92 E0; zero extuder
G1 E-1 F2000;
G1 X-82 Y85 F1000; point 1, start silicone wiping
G1 X-80 Y135; point 2
G1 X-76 Y129; point 3
G1 X-76 Y99; point 4
G1 X-64 Y99; point 5
G92 E0; zero extuder
T5; change to normal printing tool head
G90 ; switch back to absolute mode
;////////// Starting silicone //////////
G92 E0
;LAYER_COUNT:2
;LAYER:0
M106 S127.5 P1
;MESH:Wall - Angle and Fillet.STL
G0 F6000 X191.539 Y138.83 Z0.2
;TYPE:FILL
G1 F2400 X191.974 Y138.83 E0.01313
G1 X191.974 Y139.03 E0.01917
G1 X191.588 Y139.03 E0.03082
G1 X191.533 Y138.801 E0.03793
G1 X191.671 Y138.73 E0.04261
G1 X191.746 Y138.588 E0.04746
G0 F6000 X191.489 Y59.01
G0 X191.251 Y55.979
G0 X190.537 Y53.001
G0 X189.364 Y50.171
G0 X187.764 Y47.56
G0 X185.775 Y45.232
G0 X183.447 Y43.243
G0 X180.835 Y41.643
G0 X178.006 Y40.47
G0 X175.027 Y39.756
G0 X172.3 Y39.542
G0 X92.722 Y38.73
;TYPE:WALL-INNER
G1 F2400 X92.722 Y39.33 E0.06557
G1 X172.031 Y39.332 E2.4594
G1 X175.061 Y39.571 E2.55114
G1 X178.061 Y40.293 E2.64427
G1 X180.923 Y41.475 E2.73774
G1 X183.556 Y43.095 E2.83105
G1 X185.905 Y45.102 E2.9243
G1 X187.91 Y47.449 E3.01747
G1 X189.526 Y50.083 E3.11075
G1 X190.71 Y52.944 E3.20421
G1 X191.437 Y55.944 E3.29738
G1 X191.672 Y58.969 E3.38896
G1 X191.674 Y138.093 E5.7772
G1 X191.455 Y138.511 E5.79145
G1 X191.032 Y138.73 E5.80582
G1 X112.722 Y138.73 E8.1695
G1 X112.722 Y139.33 E8.18761
G1 X192.274 Y139.33 E10.58877
G1 X192.274 Y59.069 E13.01134
G1 X192.021 Y55.85 E13.1088
G1 X191.281 Y52.761 E13.20467
G1 X190.058 Y49.81 E13.30109
G1 X188.391 Y47.095 E13.39725
G1 X186.327 Y44.681 E13.49312
G1 X183.909 Y42.613 E13.58915
G1 X181.193 Y40.947 E13.68533
G1 X178.243 Y39.724 E13.78172
G1 X175.154 Y38.984 E13.87759
G1 X171.931 Y38.731 E13.97517
G1 X92.722 Y38.73 E16.36598
G0 F6000 X171.997 Y39.518
G0 X175.027 Y39.756
G0 X178.006 Y40.47
G0 X180.835 Y41.643
G0 X183.447 Y43.243
G0 X185.775 Y45.232
G0 X187.764 Y47.56
G0 X189.364 Y50.171
G0 X190.42 Y52.718
G0 X191.314 Y56.013
G0 X191.142 Y56.025
G1 F2400 X191.373 Y58.992 E16.45581
G1 X191.369 Y138.058 E18.8423
G1 X191.243 Y138.299 E18.85051
G1 X191.002 Y138.424 E18.85871
G1 X112.422 Y138.43 E21.23053
G1 X112.422 Y139.63 E21.26675
G1 X192.574 Y139.63 E23.68603
G1 X192.574 Y59.046 E26.11834
G1 X192.318 Y55.803 E26.21653
G1 X191.567 Y52.668 E26.31383
G1 X190.326 Y49.674 E26.41166
G1 X188.634 Y46.918 E26.50927
G1 X186.54 Y44.468 E26.60655
G1 X184.086 Y42.37 E26.704
G1 X181.33 Y40.679 E26.80159
G1 X178.336 Y39.438 E26.89942
G1 X175.201 Y38.687 E26.99672
G1 X171.954 Y38.431 E27.09503
G1 X92.422 Y38.43 E29.49559
G1 X92.422 Y39.63 E29.53181
G1 X172.008 Y39.631 E31.934
G1 X175.013 Y39.867 E32.02498
G1 X177.969 Y40.579 E32.11676
G1 X180.812 Y41.759 E32.20967
G1 X183.379 Y43.337 E32.30062
G1 X185.692 Y45.314 E32.39246
G1 X187.669 Y47.627 E32.4843
G1 X189.26 Y50.221 E32.57615
G1 X190.425 Y53.035 E32.66808
G1 X191.142 Y56.025 E32.76089
G0 F6000 X191.314 Y56.013
G0 X190.537 Y53.001
G0 X189.364 Y50.171
G0 X187.764 Y47.56
G0 X185.775 Y45.232
G0 X183.447 Y43.243
G0 X180.835 Y41.643
G0 X178.289 Y40.587
G0 X171.956 Y38.606
G0 X171.966 Y38.131
;TYPE:WALL-OUTER
G1 F2400 X92.122 Y38.13 E35.17086
G1 X92.122 Y39.93 E35.22519
G1 X171.984 Y39.93 E37.63571
G1 X174.965 Y40.163 E37.72597
G1 X177.878 Y40.865 E37.81641
G1 X180.655 Y42.015 E37.90713
G1 X183.21 Y43.585 E37.99765
G1 X185.479 Y45.526 E38.08777
G1 X187.429 Y47.806 E38.17833
G1 X188.994 Y50.359 E38.26871
G1 X190.139 Y53.126 E38.3591
G1 X190.842 Y56.048 E38.44981
G1 X191.074 Y59.028 E38.54003
G1 X191.073 Y138.006 E40.92387
G1 X191.031 Y138.087 E40.92662
G1 X190.95 Y138.128 E40.92936
G1 X112.122 Y138.13 E43.30867
G1 X112.122 Y139.93 E43.363
G1 X192.874 Y139.93 E45.80039
G1 X192.874 Y59.034 E48.24212
G1 X192.615 Y55.756 E48.34137
G1 X191.853 Y52.575 E48.4401
G1 X190.594 Y49.537 E48.53936
G1 X188.878 Y46.741 E48.63838
G1 X186.753 Y44.255 E48.73709
G1 X184.263 Y42.126 E48.83598
G1 X181.467 Y40.411 E48.93498
G1 X178.429 Y39.152 E49.03424
G1 X175.248 Y38.389 E49.13298
G1 X171.966 Y38.131 E49.23235
G0 F6000 X171.948 Y38.807
;MESH:NONMESH
G0 F600 X171.948 Y38.807 Z0.4
G0 F6000 X178.006 Y40.47
G0 X180.835 Y41.643
G0 X183.447 Y43.243
G0 X185.775 Y45.232
G0 X187.764 Y47.56
G0 X189.364 Y50.171
G0 X190.537 Y53.001
G0 X191.251 Y55.979
G0 X191.465 Y58.707
G0 X191.533 Y138.801
;TIME_ELAPSED:47.796854
;LAYER:1
;TYPE:FILL
;MESH:Wall - Angle and Fillet.STL
G1 F2400 X191.671 Y138.73 E49.2366
G1 X191.746 Y138.588 E49.24101
G1 X191.7 Y138.675 E49.24371
G1 X191.7 Y139.03 E49.25345
G1 X191.588 Y139.03 E49.25653
G1 X191.533 Y138.801 E49.26299
G0 F6000 X191.489 Y59.01
G0 X191.251 Y55.979
G0 X190.537 Y53.001
G0 X189.364 Y50.171
G0 X187.764 Y47.56
G0 X185.775 Y45.232
G0 X183.447 Y43.243
G0 X180.835 Y41.643
G0 X178.006 Y40.47
G0 X175.027 Y39.756
G0 X172.3 Y39.542
G0 X92.722 Y38.73
;TYPE:WALL-INNER
G1 F2400 X92.722 Y39.33 E49.27945
G1 X172.031 Y39.332 E51.45566
G1 X175.061 Y39.571 E51.53906
G1 X178.061 Y40.293 E51.62373
G1 X180.923 Y41.475 E51.7087
G1 X183.556 Y43.095 E51.79352
G1 X185.905 Y45.102 E51.8783
G1 X187.91 Y47.449 E51.963
G1 X189.526 Y50.083 E52.0478
G1 X190.71 Y52.944 E52.13276
G1 X191.437 Y55.944 E52.21746
G1 X191.672 Y58.969 E52.30072
G1 X191.674 Y138.093 E54.47185
G1 X191.455 Y138.511 E54.4848
G1 X191.032 Y138.73 E54.49787
G1 X112.722 Y138.73 E56.64666
G1 X112.722 Y139.33 E56.66313
G1 X192.274 Y139.33 E58.846
G1 X192.274 Y59.069 E61.04833
G1 X192.021 Y55.85 E61.13693
G1 X191.281 Y52.761 E61.22409
G1 X190.058 Y49.81 E61.31175
G1 X188.391 Y47.095 E61.39917
G1 X186.327 Y44.681 E61.48632
G1 X183.909 Y42.613 E61.57362
G1 X181.193 Y40.947 E61.66105
G1 X178.243 Y39.724 E61.74868
G1 X175.154 Y38.984 E61.83584
G1 X171.931 Y38.731 E61.92455
G1 X92.722 Y38.73 E64.09801
G0 F6000 X171.997 Y39.518
G0 X175.027 Y39.756
G0 X178.006 Y40.47
G0 X180.835 Y41.643
G0 X183.447 Y43.243
G0 X185.775 Y45.232
G0 X187.764 Y47.56
G0 X189.364 Y50.171
G0 X190.42 Y52.718
G0 X191.314 Y56.013
G0 X191.142 Y56.025
G1 F2400 X191.373 Y58.992 E64.17967
G1 X191.369 Y138.058 E66.34921
G1 X191.243 Y138.299 E66.35667
G1 X191.002 Y138.424 E66.36412
G1 X112.422 Y138.43 E68.52033
G1 X112.422 Y139.63 E68.55326
G1 X192.574 Y139.63 E70.7526
G1 X192.574 Y59.046 E72.96379
G1 X192.318 Y55.803 E73.05305
G1 X191.567 Y52.668 E73.14151
G1 X190.326 Y49.674 E73.23044
G1 X188.634 Y46.918 E73.31918
G1 X186.54 Y44.468 E73.40762
G1 X184.086 Y42.37 E73.49621
G1 X181.33 Y40.679 E73.58493
G1 X178.336 Y39.438 E73.67386
G1 X175.201 Y38.687 E73.76232
G1 X171.954 Y38.431 E73.85169
G1 X92.422 Y38.43 E76.03402
G1 X92.422 Y39.63 E76.06695
G1 X172.008 Y39.631 E78.25076
G1 X175.013 Y39.867 E78.33347
G1 X177.969 Y40.579 E78.4169
G1 X180.812 Y41.759 E78.50136
G1 X183.379 Y43.337 E78.58404
G1 X185.692 Y45.314 E78.66754
G1 X187.669 Y47.627 E78.75103
G1 X189.26 Y50.221 E78.83453
G1 X190.425 Y53.035 E78.9181
G1 X191.142 Y56.025 E79.00247
G0 F6000 X191.314 Y56.013
G0 X190.537 Y53.001
G0 X189.364 Y50.171
G0 X187.764 Y47.56
G0 X185.775 Y45.232
G0 X183.447 Y43.243
G0 X180.835 Y41.643
G0 X178.289 Y40.587
G0 X171.956 Y38.606
G0 X171.966 Y38.131
;TYPE:WALL-OUTER
G1 F2400 X92.122 Y38.13 E81.19336
G1 X92.122 Y39.93 E81.24275
G1 X171.984 Y39.93 E83.43413
G1 X174.965 Y40.163 E83.51618
G1 X177.878 Y40.865 E83.5984
G1 X180.655 Y42.015 E83.68087
G1 X183.21 Y43.585 E83.76316
G1 X185.479 Y45.526 E83.84509
G1 X187.429 Y47.806 E83.92742
G1 X188.994 Y50.359 E84.00958
G1 X190.139 Y53.126 E84.09175
G1 X190.842 Y56.048 E84.17422
G1 X191.074 Y59.028 E84.25624
G1 X191.073 Y138.006 E86.42336
G1 X191.031 Y138.087 E86.42587
G1 X190.95 Y138.128 E86.42836
G1 X112.122 Y138.13 E88.59137
G1 X112.122 Y139.93 E88.64076
G1 X192.874 Y139.93 E90.85656
G1 X192.874 Y59.034 E93.07632
G1 X192.615 Y55.756 E93.16654
G1 X191.853 Y52.575 E93.2563
G1 X190.594 Y49.537 E93.34653
G1 X188.878 Y46.741 E93.43655
G1 X186.753 Y44.255 E93.52629
G1 X184.263 Y42.126 E93.61619
G1 X181.467 Y40.411 E93.70619
G1 X178.429 Y39.152 E93.79643
G1 X175.248 Y38.389 E93.88619
G1 X171.966 Y38.131 E93.97652
G0 F6000 X171.948 Y38.807
;TIME_ELAPSED:92.004153
M107 P1
M140 S0
T6; Change to tool 6
G92 E0; Zero Extruder
G1 E-12 F400;
G91; change to relative mode
G1 Z5 F200;
G90 ; switch back to absolute mode
G1 X-40 Y100 F7200;
G1 Z150 F200;
M140 S0; turn off be
M104 S0; turn off extruder
M107; turn off fan
M82 ;absolute extrusion mode
;End of Gcode
;Gcode End
M82 ;absolute extrusion mode
M104 S0
;End of Gcode
;SETTING_3 {"global_quality": "[general]\\nversion = 4\\nname = SiliconeOnly_7-2
;SETTING_3 0-21\\ndefinition = custom\\n\\n[metadata]\\ntype = quality_changes\\
;SETTING_3 nquality_type = not_supported\\nsetting_version = 23\\n\\n[values]\\n
;SETTING_3 acceleration_enabled = False\\nadhesion_extruder_nr = 1\\nadhesion_ty
;SETTING_3 pe = none\\ninfill_extruder_nr = 0\\njerk_enabled = False\\nlayer_hei
;SETTING_3 ght = 0.2\\nlayer_height_0 = 0.2\\nmaterial_bed_temperature = 0\\nmat
;SETTING_3 erial_bed_temperature_layer_0 = 0\\nooze_shield_angle = 0\\nooze_shie
;SETTING_3 ld_enabled = False\\nprime_tower_enable = False\\nsupport_enable = Fa
;SETTING_3 lse\\nsupport_extruder_nr = 1\\nsupport_type = buildplate\\ntop_botto
;SETTING_3 m_extruder_nr = 0\\nwall_extruder_nr = 0\\n\\n", "extruder_quality": 
;SETTING_3 ["[general]\\nversion = 4\\nname = SiliconeOnly_7-20-21\\ndefinition 
;SETTING_3 = custom\\n\\n[metadata]\\ntype = quality_changes\\nquality_type = no
;SETTING_3 t_supported\\nintent_category = default\\nposition = 0\\nsetting_vers
;SETTING_3 ion = 23\\n\\n[values]\\nbottom_layers = 0\\ncool_fan_enabled = True\
;SETTING_3 \ncool_fan_speed = 50\\ncool_fan_speed_0 = 50\\ninfill_angles = [90,0
;SETTING_3 ]\\ninfill_before_walls = True\\ninfill_line_width = =line_width\\nin
;SETTING_3 fill_material_flow = 110\\ninfill_overlap_mm = 0\\ninfill_pattern = l
;SETTING_3 ines\\ninfill_sparse_density = 100\\ninfill_wipe_dist = 0\\njerk_prin
;SETTING_3 t = 8\\njerk_travel = 8\\nline_width = 0.3\\nmagic_mesh_surface_mode 
;SETTING_3 = normal\\nmaterial_flow = 110\\nmaterial_flow_layer_0 = 110\\nmateri
;SETTING_3 al_print_temperature = 170\\nmaterial_standby_temperature = 180\\nmin
;SETTING_3 _infill_area = 0.5\\noptimize_wall_printing_order = True\\nretract_at
;SETTING_3 _layer_change = False\\nretraction_enable = False\\nretraction_hop_af
;SETTING_3 ter_extruder_switch_height = 0\\nskin_line_width = 0.3\\nspeed_infill
;SETTING_3  = 40\\nspeed_layer_0 = 50\\nspeed_print = 40\\nspeed_topbottom = 50\
;SETTING_3 \nspeed_travel = 100\\nspeed_travel_layer_0 = 100\\nspeed_wall = 50\\
;SETTING_3 nspeed_wall_0 = 40\\nspeed_wall_x = 40\\ntop_bottom_pattern = concent
;SETTING_3 ric\\ntop_layers = 0\\ntravel_avoid_distance = 5\\ntravel_avoid_suppo
;SETTING_3 rts = False\\nwall_0_wipe_dist = 0\\nwall_line_count = 3\\nwall_line_
;SETTING_3 width = =line_width\\nwall_material_flow = 110\\nz_seam_corner = z_se
;SETTING_3 am_corner_none\\nz_seam_type = random\\nzig_zaggify_infill = True\\n\
;SETTING_3 \n", "[general]\\nversion = 4\\nname = SiliconeOnly_7-20-21\\ndefinit
;SETTING_3 ion = custom\\n\\n[metadata]\\ntype = quality_changes\\nquality_type 
;SETTING_3 = not_supported\\nintent_category = default\\nposition = 1\\nsetting_
;SETTING_3 version = 23\\n\\n[values]\\ncoasting_enable = True\\ncoasting_volume
;SETTING_3  = 0.8\\ncool_fan_speed = 50\\ncool_fan_speed_0 = 50\\ninfill_sparse_
;SETTING_3 density = 100\\njerk_support = 8\\nline_width = 0.45\\nmaterial_flow 
;SETTING_3 = 110\\nmaterial_flow_layer_0 = 110\\nmaterial_print_temperature = 18
;SETTING_3 0.0\\nmaterial_print_temperature_layer_0 = 185.0\\nmaterial_standby_t
;SETTING_3 emperature = 160.0\\nminimum_support_area = 50.0\\noptimize_wall_prin
;SETTING_3 ting_order = True\\nraft_airgap = 0\\nraft_base_line_width = 1\\nraft
;SETTING_3 _base_speed = 30\\nraft_fan_speed = 50\\nraft_interface_speed = 40\\n
;SETTING_3 raft_margin = 2\\nraft_smoothing = 1\\nraft_speed = 30\\nraft_surface
;SETTING_3 _layers = 1\\nraft_surface_line_width = =line_width\\nraft_surface_sp
;SETTING_3 eed = 50\\nretract_at_layer_change = True\\nretraction_amount = 2\\nr
;SETTING_3 etraction_combing_max_distance = 1\\nretraction_hop_after_extruder_sw
;SETTING_3 itch = False\\nretraction_hop_after_extruder_switch_height = 1\\nretr
;SETTING_3 action_hop_enabled = True\\nretraction_prime_speed = 25.0\\nretractio
;SETTING_3 n_speed = 50.0\\nspeed_layer_0 = 50\\nspeed_print = 50\\nspeed_suppor
;SETTING_3 t = 60\\nspeed_travel = 75\\nspeed_travel_layer_0 = 60\\nspeed_wall =
;SETTING_3  50\\nsupport_angle = 5\\nsupport_bottom_distance = 0\\nsupport_botto
;SETTING_3 m_stair_step_height = 0\\nsupport_infill_rate = 30\\nsupport_line_wid
;SETTING_3 th = =line_width\\nsupport_offset = 3\\nsupport_pattern = grid\\nsupp
;SETTING_3 ort_roof_enable = False\\nsupport_roof_height = 0.4\\nsupport_roof_pa
;SETTING_3 ttern = lines\\nsupport_top_distance = 0.2\\nsupport_use_towers = Fal
;SETTING_3 se\\nsupport_wall_count = 2\\nsupport_xy_distance = 0.2\\nsupport_xy_
;SETTING_3 overrides_z = xy_overrides_z\\nsupport_z_distance = 0.3\\nswitch_extr
;SETTING_3 uder_retraction_amount = 0\\ntravel_avoid_distance = 0.8\\ntravel_avo
;SETTING_3 id_other_parts = True\\nzig_zaggify_support = True\\n\\n"]}
