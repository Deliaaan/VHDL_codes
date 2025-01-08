---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:11:04 12/18/2024 
-- Design Name: 
-- Module Name:    BinHex - Behavioral 
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

entity BinHex is
    Port ( Diego : in  STD_LOGIC_VECTOR (3 downto 0);
           Nava: out  STD_LOGIC_VECTOR (6 downto 0);
			  J : out STD_LOGIC_VECTOR (3 downto 0));
end BinHex;

architecture Decodificador of BinHex is

begin
	process(Diego)
    begin
        case Diego is
            when "0000" => Nava <= "0000001"; -- 0
            when "0001" => Nava <= "1001111"; -- 1
            when "0010" => Nava <= "0010010"; -- 2
            when "0011" => Nava <= "0000110"; -- 3
            when "0100" => Nava <= "1001100"; -- 4
            when "0101" => Nava <= "0100100"; -- 5
            when "0110" => Nava <= "0100000"; -- 6
            when "0111" => Nava <= "0001111"; -- 7
            when "1000" => Nava <= "0000000"; -- 8
            when "1001" => Nava <= "0000100"; -- 9
            when "1010" => Nava <= "0001000"; -- A
            when "1011" => Nava <= "1100000"; -- B
            when "1100" => Nava <= "0110001"; -- C
            when "1101" => Nava <= "1000010"; -- D
            when "1110" => Nava <= "0110000"; -- E
            when "1111" => Nava <= "0111000"; -- F
            when others => Nava <= "1111111";
        end case;
		  
		  J <= "0111";
		  
    end process;
	 
end Decodificador;