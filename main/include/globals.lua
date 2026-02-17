--[[
Submitted to Defold Challenge #5: Break It!

I started this project to study and experiment with Defold's joints and physics.

]]--


local M = {}
-- Constants
M.VERSION = "0.0.6"
M.SFX_GAIN = 1.0
M.MUS_GAIN = 0.75
M.BODYPARTS = { "body", "leftlowerarm", "leftlowerleg", "leftupperarm", "leftupperleg",
"rightlowerarm", "rightlowerleg", "rightupperarm", "rightupperleg" }
M.POSE_TUTORIAL = {body={pos={0,0},rot=0},leftlowerarm={pos={-72.8,-0.05},rot=2.97},leftlowerleg={pos={-107.15,-99.12},rot=-69.08},leftupperarm={pos={-39.82,38.73},rot=-83.73},leftupperleg={pos={-39.89,-73.42},rot=-69.08},rightlowerarm={pos={72.82,0.95},rot=-3.09},rightlowerleg={pos={48.4,-154.32},rot=23.88},rightupperarm={pos={39.87,39.18},rot=84.61},rightupperleg={pos={21.18,-89.84},rot=21.88}}
M.POSE_POOL = {
	{
		{body={rot=0,pos={0,0}},leftlowerarm={rot=-131.65,pos={-86.96,110.45}},leftlowerleg={rot=-63.5,pos={-103.08,-108.39}},leftupperarm={rot=-131.65,pos={-33.54,62.93}},leftupperleg={rot=-63.5,pos={-38.64,-76.27}},rightlowerarm={rot=34.78,pos={68.74,-42.61}},rightlowerleg={rot=24.1,pos={46.85,-150.63}},rightupperarm={rot=34.78,pos={27.96,16.13}},rightupperleg={rot=21.87,pos={20.35,-88.02}}}, -- 8
		{body={rot=0,pos={0,0}},leftupperleg={rot=-45.53816986084,pos={-32.84,-84.41}},rightlowerarm={rot=60.367359161377,pos={100.39,-9.43}},rightupperleg={rot=51.995906829834,pos={35.21,-81.7}},rightupperarm={rot=60.367359161377,pos={37.81,26.18}},leftupperarm={rot=-59.578956604004,pos={-37.6,25.8}},rightlowerleg={rot=51.995906829834,pos={91.95,-126.04}},leftlowerleg={rot=-45.53816986084,pos={-84.23,-134.84}},leftlowerarm={rot=-59.578956604004,pos={-99.69,-10.65}}}, -- 1
		{leftupperarm={rot=-90.16,pos={-41.5,42.1}},leftupperleg={rot=-21.86,pos={-20.35,-88.02}},rightlowerarm={rot=132.73,pos={85.65,111.9}},body={rot=0,pos={0,0}},rightupperarm={rot=132.73,pos={33.14,63.38}},rightupperleg={rot=90.3,pos={42,-61.83}},rightlowerleg={rot=90.3,pos={114,-61.46}},leftlowerarm={rot=-90.16,pos={-113,42.31}},leftlowerleg={rot=-24.09,pos={-46.85,-150.63}}}, -- 7
	},
	{
		{leftlowerarm={rot=-25.84,pos={-83.07,40.22}},leftlowerleg={rot=-24.09,pos={-46.85,-150.63}},leftupperarm={rot=-117.2,pos={-36.68,55.72}},leftupperleg={rot=-21.86,pos={-20.35,-88.02}},rightlowerarm={rot=49.91,pos={88.79,-24.34}},rightlowerleg={rot=-1.1,pos={73.08,-109.64}},rightupperarm={rot=49.91,pos={34.1,21.71}},rightupperleg={rot=78.78,pos={39.43,-67.84}},body={rot=0,pos={0,0}}}, --9
		{rightupperarm={rot=95.81,pos={39.85,45.04}},rightupperleg={rot=21.87,pos={20.35,-88.02}},body={rot=0,pos={0,0}},leftlowerarm={rot=-171.07,pos={-80.43,77.32}},leftlowerleg={rot=-4.53,pos={-76.98,-106.97}},leftupperarm={rot=-90.65,pos={-40,42.34}},leftupperleg={rot=-81.07,pos={-39.64,-66.65}},rightlowerarm={rot=169.29,pos={81.17,82.97}},rightlowerleg={rot=24.1,pos={46.85,-150.63}}}, --10
		{body={pos={0,0},rot=0},leftlowerarm={pos={-86.14,111.36},rot=-132.33},leftlowerleg={pos={-44.55,-114.07},rot=44.49},leftupperarm={pos={-33.29,63.21},rot=-132.33},leftupperleg={pos={-37.27,-74.51},rot=-65.36},rightlowerarm={pos={58.2,-0.12},rot=-26.97},rightlowerleg={pos={46.85,-150.63},rot=24.1},rightupperarm={pos={39.57,36.96},rot=80.33},rightupperleg={pos={20.35,-88.02},rot=21.87}}, --11
	},
	{
		{body={pos={-68.86,-34.98},rot=0},rightlowerleg={pos={14.59,-169.18},rot=45.49},rightupperarm={pos={-27.41,5.18},rot=86.65},rightupperleg={pos={-36.4,-119.06},rot=45.49},rightlowerarm={pos={43.96,1},rot=86.65},leftlowerarm={pos={-143.46,42.91},rot=179.34},leftlowerleg={pos={-70.32,-174},rot=62.68},leftupperarm={pos={-108.86,7.44},rot=-90.78},leftupperleg={pos={-89.27,-125.11},rot=-20.3}}, --12
		{rightlowerleg={rot=2.29,pos={9.73,-106.99}},rightupperarm={rot=26.19,pos={19.53,71.66}},rightupperleg={rot=2.29,pos={6.88,-35.54}},body={rot=0,pos={-4.37,57.93}},leftlowerarm={rot=-148.13,pos={-69.28,188.26}},leftlowerleg={rot=-2.75,pos={-19.31,-106.95}},leftupperarm={rot=-148.13,pos={-31.27,127.11}},leftupperleg={rot=-2.75,pos={-15.88,-35.53}},rightlowerarm={rot=26.19,pos={51.08,7.5}}}, --13
		{rightlowerarm={rot=106.31,pos={79.13,79.84}},rightlowerleg={rot=-8.96,pos={65.2,-146.34}},rightupperarm={rot=146.84,pos={26.4,40.71}},body={rot=0,pos={0,-26.41}},rightupperleg={rot=68.95,pos={38,-99.19}},leftlowerarm={rot=-109.63,pos={-78.87,81.53}},leftlowerleg={rot=8.79,pos={-65.36,-146.23}},leftupperarm={rot=-146.46,pos={-26.57,40.6}},leftupperleg={rot=-69.05,pos={-38.02,-99.13}}}, --14
	},
	{
		{leftupperleg={rot=-35.375782012939,pos={-4.51,-68.07}},body={rot=0,pos={24.02,20.02}},rightupperleg={rot=110.7020111084,pos={62.08,-31.38}},rightupperarm={rot=99.573913574219,pos={63.6,67.01}},leftupperarm={rot=-91.669731140137,pos={-15.97,62.9}},rightlowerleg={rot=4.4936146736145,pos={97.56,-53.89}},leftlowerleg={rot=-35.375782012939,pos={-46.19,-126.78}},leftlowerarm={rot=-9.14075756073,pos={-56.52,29.37}},rightlowerarm={rot=170.44177246094,pos={103.92,107.35}}}, -- 2
		{leftlowerleg={rot=-119.72880554199,pos={-142.74,-68.07}},rightlowerarm={rot=124.36736297607,pos={53.41,43.06}},rightupperleg={rot=77.185935974121,pos={-3.18,-126.3}},rightupperarm={rot=124.36736297607,pos={-6.02,2.41}},leftupperarm={rot=-94.372772216797,pos={-82.35,-13.36}},rightlowerleg={rot=19.819040298462,pos={42.81,-166.99}},leftupperleg={rot=-119.72880554199,pos={-80.22,-103.78}},body={rot=0,pos={-42.44,-57.65}},leftlowerarm={rot=178.91256713867,pos={-116.58,24.3}}}, -- 3
		{rightlowerarm={pos={31.62,-22.57},rot=46.36},rightlowerleg={pos={12.85,-142.11},rot=32.9},rightupperarm={pos={-20.49,27.12},rot=46.36},body={pos={-53.65,7.21},rot=0},rightupperleg={pos={-26.26,-81.66},rot=32.9},leftlowerarm={pos={-130.82,128.6},rot=-139.72},leftlowerleg={pos={-117.91,-94.58},rot=17.34},leftupperarm={pos={-84.31,73.64},rot=-139.78},leftupperleg={pos={-93.5,-57.74},rot=-84.36}}, -- 4
	},
	{
		{body={pos={39.23,-70.46},rot=0},leftlowerarm={pos={-39.44,-20.96},rot=-164.73},leftlowerleg={pos={-67.7,-170.14},rot=-68.75},leftupperarm={pos={1.79,-40.58},rot=-66.16},leftupperleg={pos={-0.59,-144.05},rot=-68.75},rightlowerarm={pos={111.39,-18.99},rot=176.14},rightlowerleg={pos={104.95,-157.11},rot=-14.25},rightupperarm={pos={76.84,-40.21},rot=66.95},rightupperleg={pos={78.93,-128.18},rot=98.2}}, -- 5
		{leftlowerarm={pos={-76.52,38.97},rot=-77.39},body={pos={34.98,19.67},rot=0},leftupperarm={pos={-6.25,54.69},rot=-77.39},leftupperleg={pos={-2.69,-53.92},rot=-67.26},rightlowerarm={pos={118.76,93.11},rot=60.76},rightlowerleg={pos={93.85,-54.13},rot=-21.28},rightupperarm={pos={64.94,84.07},rot=138.29},rightupperleg={pos={73.4,-32.72},rot=108.67},leftlowerleg={pos={-14.3,-95.69},rot=36.22}}, -- 15
		{leftlowerarm={rot=-50.08,pos={-169.88,4.32}},leftlowerleg={rot=-22.14,pos={-130.08,-129.91}},leftupperarm={rot=-50.08,pos={-115.04,50.2}},leftupperleg={rot=-22.14,pos={-102.94,-63.22}},rightlowerarm={rot=70.61,pos={20.78,86.82}},rightlowerleg={rot=76.14,pos={25.75,-24.65}},rightupperarm={rot=115.54,pos={-43.82,83.35}},rightupperleg={rot=105.45,pos={-41.97,-25.59}},body={rot=0,pos={-80.88,28.42}}} -- 16
	},
	{
		{leftupperarm={rot=-134.28,pos={52.41,45.67}},leftupperleg={rot=-90.68,pos={-4.27,-68.08}},rightlowerarm={rot=19.28,pos={125.49,-80.43}},body={rot=-26.35,pos={64.21,-17.35}},rightupperarm={rot=19.28,pos={102.05,-13.41}},rightupperleg={rot=5.97,pos={48.84,-107.88}},rightlowerleg={rot=5.97,pos={56.19,-178.2}},leftlowerarm={rot=-174.98,pos={24.29,104.97}},leftlowerleg={rot=-90.67,pos={-76.26,-67.23}}}, -- 6
		{leftlowerarm={rot=9.09,pos={-121.58,-24.93}},leftlowerleg={rot=27.42,pos={-51.74,-148.84}},leftupperarm={rot=-81.23,pos={-92.51,14.96}},rightlowerarm={rot=73.18,pos={53.87,-1.86}},rightlowerleg={rot=39.3,pos={64.92,-146.87}},rightupperarm={rot=73.18,pos={-14.57,18.83}},rightupperleg={rot=39.3,pos={19.32,-91.15}},body={rot=24.91,pos={-36.11,-14.35}},leftupperleg={rot=-48.63,pos={-41.59,-94.63}}}, -- 17
		{leftlowerleg={rot=-50.12,pos={-109.33,-149.19}},leftupperarm={rot=-79.79,pos={19.55,-23.31}},leftupperleg={rot=-50.12,pos={-54.46,-103.35}},rightlowerarm={rot=-8.9,pos={115.5,-97.62}},rightlowerleg={rot=43.13,pos={53.45,-174.55}},rightupperarm={rot=62.75,pos={89.81,-47.01}},body={rot=-51.01,pos={24.2,-51.93}},rightupperleg={rot=43.2,pos={4.2,-122.03}},leftlowerarm={rot=-79.79,pos={-50.82,-35.96}}}, -- 18
	},
	{
		{leftlowerarm={pos={-134.4,68.07},rot=-52.38},leftlowerleg={pos={-28.98,-85.16},rot=73.89},leftupperarm={pos={-81.42,65.19},rot=-133.82},leftupperleg={pos={-31.88,-58.69},rot=-61.38},rightlowerarm={pos={57.17,29.72},rot=75.88},rightlowerleg={pos={112.43,-59.04},rot=76},rightupperarm={pos={-12.17,47.16},rot=75.88},rightupperleg={pos={42.57,-41.63},rot=76},body={pos={-29.35,13.8},rot=31.44}}, -- 19
		{body={pos={-63.66,-46.45},rot=-28.18},leftupperleg={pos={-112.03,-125.23},rot=-18.96},rightlowerarm={pos={14.45,-19.68},rot=-15.01},leftlowerarm={pos={-148.13,-19.38},rot=-60.71},leftlowerleg={pos={-95.24,-182.07},rot=49.99},leftupperarm={pos={-82.62,-3.58},rot=-92.14},rightlowerleg={pos={17.8,-120.59},rot=81.76},rightupperarm={pos={-8,-1.1},rot=115.79},rightupperleg={pos={-52.96,-110.34},rot=81.76}}, -- 20
		{rightlowerarm={rot=178.77,pos={169.53,47.55}},body={rot=-30.74,pos={73.96,-12.86}},rightupperarm={rot=85.08,pos={133.91,15.56}},rightupperleg={rot=63.19,pos={77.64,-84.79}},rightlowerleg={rot=-36.38,pos={88.12,-128.75}},leftlowerarm={rot=-102.77,pos={-13.62,51.12}},leftlowerleg={rot=32.18,pos={-10.21,-72.71}},leftupperarm={rot=-102.77,pos={56.11,35.32}},leftupperleg={rot=-105.74,pos={4.92,-52.62}}} -- 21
	}
}

M.allow_click = true
M.time_played = 0
M.cur_screen = 1
M.dummy_ids = nil
M.silhouette_ids = nil
M.mask_ids = nil
M.dummy_script = nil
M.mask_script = nil
M.instance_id = nil
M.dummy_pos = nil
M.sil_pos = nil
M.sil_scale = 1
M.bodypart_selected = ""
M.debug_text = ""

-- Needs to be saved (player data)
M.sfx = 1
M.music = 1
M.cur_level_main = 1
M.cur_level_sub = 1
M.actual_time_played = 0
M.display_mode = 0
M.pose_index = 1

M.pose_debug = false -- for debugging
M.pose_default = {body={pos={0,0},rot=0},rightupperarm={pos={39.87,39.18},rot=84.61},rightupperleg={pos={19.94,-92.42},rot=18.1},rightlowerleg={pos={42.31,-160.86},rot=18.1},leftlowerarm={pos={-72.8,-0.05},rot=2.97},leftlowerleg={pos={-42.31,-160.86},rot=-18.09},leftupperarm={pos={-39.82,38.73},rot=-83.73},leftupperleg={pos={-19.94,-92.42},rot=-18.09},rightlowerarm={pos={72.82,0.95},rot=-3.09}} -- for debugging
M.poses = {}

return M