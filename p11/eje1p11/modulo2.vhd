-- filepath: display_controller.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DisplayController is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        count : in STD_LOGIC_VECTOR (15 downto 0);
        segments : out STD_LOGIC_VECTOR (6 downto 0);
        digit_select : out STD_LOGIC_VECTOR (3 downto 0)
    );
end DisplayController;

architecture Behavioral of DisplayController is
    signal digit : STD_LOGIC_VECTOR (3 downto 0);
    signal digit_value : STD_LOGIC_VECTOR (3 downto 0);
    signal refresh_counter : INTEGER := 0;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            refresh_counter <= 0;
            digit <= "0000";
        elsif rising_edge(clk) then
            refresh_counter <= refresh_counter + 1;
            if refresh_counter = 100000 then
                refresh_counter <= 0;
                digit <= digit + 1;
                if digit = "1000" then
                    digit <= "0000";
                end if;
            end if;
        end if;
    end process;

    process(digit)
    begin
        case digit is
            when "0000" => digit_value <= count(3 downto 0);
            when "0001" => digit_value <= count(7 downto 4);
            when "0010" => digit_value <= count(11 downto 8);
            when "0011" => digit_value <= count(15 downto 12);
            when others => digit_value <= "0000";
        end case;
    end process;

    process(digit_value)
    begin
        case digit_value is
            when "0000" => segments <= "0111111";
            when "0001" => segments <= "0000110";
            when "0010" => segments <= "1011011";
            when "0011" => segments <= "1001111";
            when "0100" => segments <= "1100110";
            when "0101" => segments <= "1101101";
            when "0110" => segments <= "1111101";
            when "0111" => segments <= "0000111";
            when "1000" => segments <= "1111111";
            when "1001" => segments <= "1101111";
            when others => segments <= "0000000";
        end case;
    end process;

    digit_select <= "1110" when digit = "0000" else
                    "1101" when digit = "0001" else
                    "1011" when digit = "0010" else
                    "0111";
end Behavioral;