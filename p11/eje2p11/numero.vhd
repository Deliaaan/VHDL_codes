library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DisplayDriver is
    Port ( an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end DisplayDriver;

architecture Behavioral of DisplayDriver is
    -- Mapa de segmentos para los dígitos 0-9
    type seg_map is array (0 to 9) of STD_LOGIC_VECTOR (6 downto 0);
    constant SEGMENTS : seg_map := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000"  -- 9
    );

begin
    -- Asignar valores a cada display
    an <= "1110"; -- Activar el primer display
    seg <= SEGMENTS(1); -- Mostrar el dígito 1 en el primer display

    an <= "1101"; -- Activar el segundo display
    seg <= SEGMENTS(6); -- Mostrar el dígito 6 en el segundo display

    an <= "1011"; -- Activar el tercer display
    seg <= SEGMENTS(4); -- Mostrar el dígito 4 en el tercer display

    an <= "0111"; -- Activar el cuarto display
    seg <= SEGMENTS(5); -- Mostrar el dígito 5 en el cuarto display
end Behavioral;