-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "01/05/2020 11:19:52"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          bricks_matrix
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

PACKAGE bricks_matrix_data_type IS 
TYPE matrix_0_16_type IS ARRAY (0 TO 16) OF STD_LOGIC;
TYPE matrix_0_16_0_13_type IS ARRAY (0 TO 13) OF matrix_0_16_type;
SUBTYPE matrix_type IS matrix_0_16_0_13_type;
END bricks_matrix_data_type;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

library work;
use work.bricks_matrix_data_type.all;

ENTITY bricks_matrix_vhd_vec_tst IS
END bricks_matrix_vhd_vec_tst;
ARCHITECTURE bricks_matrix_arch OF bricks_matrix_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL RGBout : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL brickCollision1X : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL brickCollision1Y : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL brickNum : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL changeMap : STD_LOGIC;
SIGNAL clk : STD_LOGIC;
SIGNAL collision : STD_LOGIC;
SIGNAL drawingRequest : STD_LOGIC;
SIGNAL mapNum : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL matrix : matrix_type;
SIGNAL offsetX : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL offsetY : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL pixelX : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL pixelY : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL randomMap : STD_LOGIC;
SIGNAL resetN : STD_LOGIC;
SIGNAL topLeftX : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL topLeftY : STD_LOGIC_VECTOR(10 DOWNTO 0);
COMPONENT bricks_matrix
	PORT (
	RGBout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	brickCollision1X : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	brickCollision1Y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	brickNum : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	changeMap : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	collision : IN STD_LOGIC;
	drawingRequest : OUT STD_LOGIC;
	mapNum : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	matrix : OUT matrix_type;
	offsetX : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	offsetY : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	pixelX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
	pixelY : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
	randomMap : IN STD_LOGIC;
	resetN : IN STD_LOGIC;
	topLeftX : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
	topLeftY : IN STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : bricks_matrix
	PORT MAP (
-- list connections between master ports and signals
	RGBout => RGBout,
	brickCollision1X => brickCollision1X,
	brickCollision1Y => brickCollision1Y,
	brickNum => brickNum,
	changeMap => changeMap,
	clk => clk,
	collision => collision,
	drawingRequest => drawingRequest,
	mapNum => mapNum,
	matrix => matrix,
	offsetX => offsetX,
	offsetY => offsetY,
	pixelX => pixelX,
	pixelY => pixelY,
	randomMap => randomMap,
	resetN => resetN,
	topLeftX => topLeftX,
	topLeftY => topLeftY
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
LOOP
	clk <= '0';
	WAIT FOR 2500 ps;
	clk <= '1';
	WAIT FOR 2500 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk;

-- resetN
t_prcs_resetN: PROCESS
BEGIN
	resetN <= '0';
	WAIT FOR 20000 ps;
	resetN <= '1';
WAIT;
END PROCESS t_prcs_resetN;
-- pixelX[10]
t_prcs_pixelX_10: PROCESS
BEGIN
	pixelX(10) <= '0';
WAIT;
END PROCESS t_prcs_pixelX_10;
-- pixelX[9]
t_prcs_pixelX_9: PROCESS
BEGIN
	pixelX(9) <= '0';
WAIT;
END PROCESS t_prcs_pixelX_9;
-- pixelX[8]
t_prcs_pixelX_8: PROCESS
BEGIN
	pixelX(8) <= '0';
WAIT;
END PROCESS t_prcs_pixelX_8;
-- pixelX[7]
t_prcs_pixelX_7: PROCESS
BEGIN
	pixelX(7) <= '0';
WAIT;
END PROCESS t_prcs_pixelX_7;
-- pixelX[6]
t_prcs_pixelX_6: PROCESS
BEGIN
	pixelX(6) <= '0';
WAIT;
END PROCESS t_prcs_pixelX_6;
-- pixelX[5]
t_prcs_pixelX_5: PROCESS
BEGIN
	FOR i IN 1 TO 6
	LOOP
		pixelX(5) <= '0';
		WAIT FOR 80000 ps;
		pixelX(5) <= '1';
		WAIT FOR 80000 ps;
	END LOOP;
	pixelX(5) <= '0';
WAIT;
END PROCESS t_prcs_pixelX_5;
-- pixelX[4]
t_prcs_pixelX_4: PROCESS
BEGIN
	FOR i IN 1 TO 12
	LOOP
		pixelX(4) <= '0';
		WAIT FOR 40000 ps;
		pixelX(4) <= '1';
		WAIT FOR 40000 ps;
	END LOOP;
	pixelX(4) <= '0';
WAIT;
END PROCESS t_prcs_pixelX_4;
-- pixelX[3]
t_prcs_pixelX_3: PROCESS
BEGIN
LOOP
	pixelX(3) <= '0';
	WAIT FOR 20000 ps;
	pixelX(3) <= '1';
	WAIT FOR 20000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_pixelX_3;
-- pixelX[2]
t_prcs_pixelX_2: PROCESS
BEGIN
LOOP
	pixelX(2) <= '0';
	WAIT FOR 10000 ps;
	pixelX(2) <= '1';
	WAIT FOR 10000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_pixelX_2;
-- pixelX[1]
t_prcs_pixelX_1: PROCESS
BEGIN
LOOP
	pixelX(1) <= '0';
	WAIT FOR 5000 ps;
	pixelX(1) <= '1';
	WAIT FOR 5000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_pixelX_1;
-- pixelX[0]
t_prcs_pixelX_0: PROCESS
BEGIN
LOOP
	pixelX(0) <= '0';
	WAIT FOR 2500 ps;
	pixelX(0) <= '1';
	WAIT FOR 2500 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_pixelX_0;
-- pixelY[10]
t_prcs_pixelY_10: PROCESS
BEGIN
	pixelY(10) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_10;
-- pixelY[9]
t_prcs_pixelY_9: PROCESS
BEGIN
	pixelY(9) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_9;
-- pixelY[8]
t_prcs_pixelY_8: PROCESS
BEGIN
	pixelY(8) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_8;
-- pixelY[7]
t_prcs_pixelY_7: PROCESS
BEGIN
	pixelY(7) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_7;
-- pixelY[6]
t_prcs_pixelY_6: PROCESS
BEGIN
	pixelY(6) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_6;
-- pixelY[5]
t_prcs_pixelY_5: PROCESS
BEGIN
	pixelY(5) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_5;
-- pixelY[4]
t_prcs_pixelY_4: PROCESS
BEGIN
	pixelY(4) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_4;
-- pixelY[3]
t_prcs_pixelY_3: PROCESS
BEGIN
	pixelY(3) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_3;
-- pixelY[2]
t_prcs_pixelY_2: PROCESS
BEGIN
	pixelY(2) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_2;
-- pixelY[1]
t_prcs_pixelY_1: PROCESS
BEGIN
	pixelY(1) <= '0';
	WAIT FOR 320000 ps;
	pixelY(1) <= '1';
	WAIT FOR 320000 ps;
	pixelY(1) <= '0';
	WAIT FOR 320000 ps;
	pixelY(1) <= '1';
WAIT;
END PROCESS t_prcs_pixelY_1;
-- pixelY[0]
t_prcs_pixelY_0: PROCESS
BEGIN
	FOR i IN 1 TO 3
	LOOP
		pixelY(0) <= '0';
		WAIT FOR 160000 ps;
		pixelY(0) <= '1';
		WAIT FOR 160000 ps;
	END LOOP;
	pixelY(0) <= '0';
WAIT;
END PROCESS t_prcs_pixelY_0;
-- topLeftX[10]
t_prcs_topLeftX_10: PROCESS
BEGIN
	topLeftX(10) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_10;
-- topLeftX[9]
t_prcs_topLeftX_9: PROCESS
BEGIN
	topLeftX(9) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_9;
-- topLeftX[8]
t_prcs_topLeftX_8: PROCESS
BEGIN
	topLeftX(8) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_8;
-- topLeftX[7]
t_prcs_topLeftX_7: PROCESS
BEGIN
	topLeftX(7) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_7;
-- topLeftX[6]
t_prcs_topLeftX_6: PROCESS
BEGIN
	topLeftX(6) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_6;
-- topLeftX[5]
t_prcs_topLeftX_5: PROCESS
BEGIN
	topLeftX(5) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_5;
-- topLeftX[4]
t_prcs_topLeftX_4: PROCESS
BEGIN
	topLeftX(4) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_4;
-- topLeftX[3]
t_prcs_topLeftX_3: PROCESS
BEGIN
	topLeftX(3) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_3;
-- topLeftX[2]
t_prcs_topLeftX_2: PROCESS
BEGIN
	topLeftX(2) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_2;
-- topLeftX[1]
t_prcs_topLeftX_1: PROCESS
BEGIN
	topLeftX(1) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_1;
-- topLeftX[0]
t_prcs_topLeftX_0: PROCESS
BEGIN
	topLeftX(0) <= '0';
WAIT;
END PROCESS t_prcs_topLeftX_0;
-- topLeftY[10]
t_prcs_topLeftY_10: PROCESS
BEGIN
	topLeftY(10) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_10;
-- topLeftY[9]
t_prcs_topLeftY_9: PROCESS
BEGIN
	topLeftY(9) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_9;
-- topLeftY[8]
t_prcs_topLeftY_8: PROCESS
BEGIN
	topLeftY(8) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_8;
-- topLeftY[7]
t_prcs_topLeftY_7: PROCESS
BEGIN
	topLeftY(7) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_7;
-- topLeftY[6]
t_prcs_topLeftY_6: PROCESS
BEGIN
	topLeftY(6) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_6;
-- topLeftY[5]
t_prcs_topLeftY_5: PROCESS
BEGIN
	topLeftY(5) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_5;
-- topLeftY[4]
t_prcs_topLeftY_4: PROCESS
BEGIN
	topLeftY(4) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_4;
-- topLeftY[3]
t_prcs_topLeftY_3: PROCESS
BEGIN
	topLeftY(3) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_3;
-- topLeftY[2]
t_prcs_topLeftY_2: PROCESS
BEGIN
	topLeftY(2) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_2;
-- topLeftY[1]
t_prcs_topLeftY_1: PROCESS
BEGIN
	topLeftY(1) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_1;
-- topLeftY[0]
t_prcs_topLeftY_0: PROCESS
BEGIN
	topLeftY(0) <= '0';
WAIT;
END PROCESS t_prcs_topLeftY_0;
-- mapNum[1]
t_prcs_mapNum_1: PROCESS
BEGIN
	mapNum(1) <= '0';
WAIT;
END PROCESS t_prcs_mapNum_1;
-- mapNum[0]
t_prcs_mapNum_0: PROCESS
BEGIN
	mapNum(0) <= '0';
WAIT;
END PROCESS t_prcs_mapNum_0;

-- changeMap
t_prcs_changeMap: PROCESS
BEGIN
	changeMap <= '0';
WAIT;
END PROCESS t_prcs_changeMap;

-- randomMap
t_prcs_randomMap: PROCESS
BEGIN
	randomMap <= '1';
	WAIT FOR 30000 ps;
	randomMap <= '0';
WAIT;
END PROCESS t_prcs_randomMap;

-- collision
t_prcs_collision: PROCESS
BEGIN
	collision <= '0';
	WAIT FOR 80000 ps;
	collision <= '1';
	WAIT FOR 10000 ps;
	collision <= '0';
WAIT;
END PROCESS t_prcs_collision;
-- brickCollision1X[4]
t_prcs_brickCollision1X_4: PROCESS
BEGIN
	brickCollision1X(4) <= '0';
WAIT;
END PROCESS t_prcs_brickCollision1X_4;
-- brickCollision1X[3]
t_prcs_brickCollision1X_3: PROCESS
BEGIN
	brickCollision1X(3) <= '0';
WAIT;
END PROCESS t_prcs_brickCollision1X_3;
-- brickCollision1X[2]
t_prcs_brickCollision1X_2: PROCESS
BEGIN
	brickCollision1X(2) <= '0';
WAIT;
END PROCESS t_prcs_brickCollision1X_2;
-- brickCollision1X[1]
t_prcs_brickCollision1X_1: PROCESS
BEGIN
	brickCollision1X(1) <= '0';
WAIT;
END PROCESS t_prcs_brickCollision1X_1;
-- brickCollision1X[0]
t_prcs_brickCollision1X_0: PROCESS
BEGIN
	brickCollision1X(0) <= '1';
WAIT;
END PROCESS t_prcs_brickCollision1X_0;
-- brickCollision1Y[3]
t_prcs_brickCollision1Y_3: PROCESS
BEGIN
	brickCollision1Y(3) <= '0';
WAIT;
END PROCESS t_prcs_brickCollision1Y_3;
-- brickCollision1Y[2]
t_prcs_brickCollision1Y_2: PROCESS
BEGIN
	brickCollision1Y(2) <= '0';
WAIT;
END PROCESS t_prcs_brickCollision1Y_2;
-- brickCollision1Y[1]
t_prcs_brickCollision1Y_1: PROCESS
BEGIN
	brickCollision1Y(1) <= '0';
WAIT;
END PROCESS t_prcs_brickCollision1Y_1;
-- brickCollision1Y[0]
t_prcs_brickCollision1Y_0: PROCESS
BEGIN
	brickCollision1Y(0) <= '0';
WAIT;
END PROCESS t_prcs_brickCollision1Y_0;
END bricks_matrix_arch;
