----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:43:08 01/05/2025 
-- Design Name: 
-- Module Name:    adder_subtractor_4bits - behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 4-bit adder/subtractor with behavioral implementation
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY SumResBIN IS 
    PORT (
        a, b   : IN STD_LOGIC_VECTOR(3 downto 0);
        d      : IN STD_LOGIC;
        c      : OUT STD_LOGIC_VECTOR(4 downto 0) -- Cambiado a 5 bits
    );
END SumResBIN;

ARCHITECTURE restadorSumador OF SumResBIN IS
BEGIN
    c <= ('0' & a) - ('0' & b) when d = '1' else ('0' & a) + ('0' & b);
    -- Se añade un bit adicional para manejar los casos donde el resultado sea de 5 bits
END restadorSumador;

