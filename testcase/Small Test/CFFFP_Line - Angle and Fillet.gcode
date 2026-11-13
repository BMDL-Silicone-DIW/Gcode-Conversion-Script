;FLAVOR:Marlin
;TIME:10
;Filament used: 0.0101182m, 0m
;Layer height: 0.2
;MINX:82.574
;MINY:39.15
;MINZ:0.2
;MAXX:202.422
;MAXY:159.15
;MAXZ:0.2
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
;MESH:Line - Angle and Fillet.STL
G0 F6000 X102.574 Y159.15 Z0.2
;TYPE:WALL-OUTER
G1 F2392 X110.252 Y159.15 E0.23252
G1 F2376.2 X117.93 Y159.15 E0.46659
G1 F2360.7 X125.608 Y159.15 E0.7022
G1 F2345.3 X133.286 Y159.15 E0.93936
G1 F2330.1 X140.964 Y159.15 E1.17806
G1 F2315.1 X148.642 Y159.15 E1.41831
G1 F2300.3 X156.32 Y159.15 E1.6601
G1 F2285.7 X163.998 Y159.15 E1.90344
G1 F2271.3 X171.676 Y159.15 E2.14832
G1 F2257.1 X179.354 Y159.15 E2.39474
G1 F2243 X187.032 Y159.15 E2.64272
G1 F2229.1 X194.71 Y159.15 E2.89223
G1 F2215.4 X202.388 Y159.15 E3.1433
G1 F2293 X202.421 Y159.026 E3.14735
G1 F2392 X202.422 Y59.154 E6.17189
G1 F2408 X202.176 Y56.019 E6.26649
G1 F2424.2 X201.441 Y52.959 E6.36053
G1 F2416.1 X200.24 Y50.066 E6.45445
G1 F2392 X198.599 Y47.39 E6.54951
G1 F2400 X196.57 Y45.014 E6.64382
G1 X194.186 Y42.977 E6.73847
G1 F2392 X191.51 Y41.336 E6.83353
G1 F2416.1 X188.595 Y40.128 E6.92814
G1 F2440.7 X185.557 Y39.398 E7.02087
G1 F2432.4 X182.414 Y39.15 E7.11477
G1 F2408 X82.574 Y39.15 E10.11825
;TIME_ELAPSED:10.305264
;LAYER:1
;This layer is just bare motions to pass MATLAB script
G1 X200 Y100
G1 X100 Y200
;TIME_ELAPSED:17.1243
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
