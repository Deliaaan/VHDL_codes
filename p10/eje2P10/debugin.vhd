----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:52 01/02/2025 
-- Design Name: 
-- Module Name:    decoder4bits - deco 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

	entity decoder4bits is
		 Port (
			  D : in STD_LOGIC_VECTOR (0 to 3); 			-- Entrada de 4 bits
			  E : in STD_LOGIC_VECTOR (0 to 1); 			-- Selección de 2 bits
			  SEG : out STD_LOGIC_VECTOR (0 to 6); 		-- Salida de SEGMENTOS
			  DISPLAY : out STD_LOGIC_VECTOR (0 to 3);  -- salida de DISPLAY
			  A : out STD_LOGIC_VECTOR (0 to 7)			-- Salida de LEDS
		 );
	end decoder4bits;

	architecture deco of decoder4bits is

	begin
	process(E, D)
		 begin
				if E = "00" then
				-- codigo gray
					case D is
						when "0000" => A <= "00000000"; -- 0
						when "0001" => A <= "00000001"; -- 1
						when "0010" => A <= "00000011"; -- 2
						when "0011" => A <= "00000010"; -- 3
						when "0100" => A <= "00000110"; -- 4
						when "0101" => A <= "00000111"; -- 5
						when "0110" => A <= "00000101"; -- 6
						when "0111" => A <= "00000100"; -- 7
						when "1000" => A <= "00001100"; -- 8
						when "1001" => A <= "00001101"; -- 9
						when "1010" => A <= "00001111"; -- 10
						when "1011" => A <= "00001110"; -- 11
						when "1100" => A <= "00001010"; -- 12
						when "1101" => A <= "00001011"; -- 13
						when "1110" => A <= "00001001"; -- 14
						when "1111" => A <= "00001000"; -- 15
						when others => A <= "00000000";
					end case;						 
				elsif E = "01" then 
				-- ex3
					case D is
						when "0000" => A <= "00000011"; -- 0
						when "0001" => A <= "00000100"; -- 1
						when "0010" => A <= "00000101"; -- 2
						when "0011" => A <= "00000110"; -- 3
						when "0100" => A <= "00000111"; -- 4
						when "0101" => A <= "00001000"; -- 5
						when "0110" => A <= "00001001"; -- 6
						when "0111" => A <= "00001010"; -- 7
						when "1000" => A <= "00001011"; -- 8
						when "1001" => A <= "00001100"; -- 9
						when "1010" => A <= "01000011"; -- 10
						when "1011" => A <= "01000100"; -- 11
						when "1100" => A <= "01000101"; -- 12
						when "1101" => A <= "01000110"; -- 13
						when "1110" => A <= "01000111"; -- 14
						when "1111" => A <= "01001000"; -- 15
						when others => A <= "00000000";
					end case;
				elsif E = "10" then 
				-- BCD debe usar solo un display siendo asi el "1110"
					case D is 
						when "0000" => SEG <= "0000001"; -- 0
						when "0001" => SEG <= "1001111"; -- 1
						when "0010" => SEG <= "0010010"; -- 2
						when "0011" => SEG <= "0000110"; -- 3
						when "0100" => SEG <= "1001100"; -- 4
						when "0101" => SEG <= "0100100"; -- 5
						when "0110" => SEG <= "0100000"; -- 6
						when "0111" => SEG <= "0001111"; -- 7
						when "1000" => SEG <= "0000000"; -- 8
						when "1001" => SEG <= "0000100"; -- 9
						when others => SEG <= "1111111";
					end case;
				else 
				-- Binario a Octal debe ser en dos displays 
					case D is
						when "0000" => SEG <= "0000001"; -- 0 = 0 
						when "0001" => SEG <= "1001111"; -- 1 = 1
						when "0010" => SEG <= "0010010"; -- 2 = 2
						when "0011" => SEG <= "0000110"; -- 3 = 3 
						when "0100" => SEG <= "1001100"; -- 4 = 4
						when "0101" => SEG <= "0100100"; -- 5 = 5
						when "0110" => SEG <= "0100000"; -- 6 = 6
						when "0111" => SEG <= "0001111"; -- 7 = 7
						when "1000" => SEG <= "0000000"; -- 8 = 10
						when "1001" => SEG <= "0000100"; -- 9 = 11
						when "1010" => SEG <= "0100001"; -- 10 = 12
						when "1011" => SEG <= "0100010"; -- 11 = 13
						when "1100" => SEG <= "0100001"; -- 12 = 14
						when "1101" => SEG <= "0100110"; -- 13 = 15
						when "1110" => SEG <= "0100111"; -- 14 = 16
						when "1111" => SE	G <= "0101000"; -- 15 = 17
						when others => SEG <= "1111111";
					end case;
					
					
				end if;
		end process;
	end deco;

