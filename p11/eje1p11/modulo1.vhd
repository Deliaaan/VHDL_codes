-- filepath: /home/zelian/Documentos/repos/practicas/eje1P11/modulo1.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Contador is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        up_down : in STD_LOGIC; -- 1 para ascendente, 0 para descendente
        count : out STD_LOGIC_VECTOR (15 downto 0) -- 4 dígitos BCD
    );
end Contador;

architecture Behavioral of Contador is
    signal temp_count : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    signal slow_clk : STD_LOGIC;
    signal counter : INTEGER := 0;
    signal clk_div : STD_LOGIC := '0';
    constant DIVISOR : INTEGER := 50000000; -- Ajusta este valor según la frecuencia deseada
begin
    -- Divisor de frecuencia
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            clk_div <= '0';
        elsif rising_edge(clk) then
            if counter = DIVISOR / 2 - 1 then
                counter <= 0;
                clk_div <= not clk_div;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    slow_clk <= clk_div;

    -- Contador ascendente/descendente
    process(slow_clk, reset)
    begin
        if reset = '1' then
            temp_count <= (others => '0');
        elsif rising_edge(slow_clk) then
            if up_down = '1' then
                temp_count <= temp_count + 1;
            else
                temp_count <= temp_count - 1;
            end if;
        end if;
    end process;
    count <= temp_count;
end Behavioral;