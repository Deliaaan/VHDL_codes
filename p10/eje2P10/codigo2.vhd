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
-- Optimizado para mejor claridad y mantenimiento.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Añadir esta librería para usar to_integer

entity decoder4bits is
    Port (
        D       : in STD_LOGIC_VECTOR (0 to 3);   -- Entrada de 4 bits
        E       : in STD_LOGIC_VECTOR (0 to 1);   -- Selección de 2 bits
        SEG     : out STD_LOGIC_VECTOR (0 to 6);  -- Salida de SEGMENTOS
        DISPLAY : out STD_LOGIC_VECTOR (0 to 3);  -- Salida de DISPLAY
        A       : out STD_LOGIC_VECTOR (0 to 7)   -- Salida de LEDS
    );
end decoder4bits;

architecture deco of decoder4bits is

    -- Tablas de valores para los segmentos
    type seg_table is array (0 to 9) of STD_LOGIC_VECTOR (0 to 6);
    constant SEG_VALUES : seg_table := (
        "0000001", -- 0
        "1001111", -- 1
        "0010010", -- 2
        "0000110", -- 3
        "1001100", -- 4
        "0100100", -- 5
        "0100000", -- 6
        "0001111", -- 7
        "0000000", -- 8
        "0000100", -- 9
    );

    -- Tablas de valores para LEDS (Gray y Ex3)
    type led_table is array (0 to 15) of STD_LOGIC_VECTOR (0 to 7);
    constant GRAY_VALUES : led_table := (
        "00000000", "00000001", "00000011", "00000010", 
        "00000110", "00000111", "00000101", "00000100", 
        "00001100", "00001101", "00001111", "00001110", 
        "00001010", "00001011", "00001001", "00001000"
    );
    constant EX3_VALUES : led_table := (
        "00000011", "00000100", "00000101", "00000110", 
        "00000111", "00001000", "00001001", "00001010", 
        "00001011", "00001100", "01000011", "01000100", 
        "01000101", "01000110", "01000111", "01001000"
    );

    signal SEG1 : STD_LOGIC_VECTOR (0 to 6);  -- Segmentos para el primer display
    signal SEG2 : STD_LOGIC_VECTOR (0 to 6);  -- Segmentos para el segundo display

begin
    process(E, D)
        variable index : integer;
    begin
        -- Convertir la entrada D a un índice entero
        index := to_integer(unsigned(D));

        case E is
            when "00" =>
                -- Código Gray
                A <= GRAY_VALUES(index);
                DISPLAY <= "1111"; -- Apagar los displays
                SEG1 <= "1111111";
                SEG2 <= "1111111";

            when "01" =>
                -- Código Ex3
                A <= EX3_VALUES(index);
                DISPLAY <= "1111"; -- Apagar los displays
                SEG1 <= "1111111";
                SEG2 <= "1111111";

            when "10" =>
                -- BCD: Activar un solo display
                A <= (others => '0'); -- No afecta LEDs
                DISPLAY <= "1110";    -- Activar solo el primer display
                SEG1 <= SEG_VALUES(index);
                SEG2 <= "1111111";    -- Apagar el segundo display

            when others =>
                -- Binario a Octal: Activar ambos displays
                A <= (others => '0'); -- No afecta LEDs
                DISPLAY <= "1100";    -- Activar ambos displays
                if index < 8 then
                    SEG1 <= SEG_VALUES(index);
                    SEG2 <= "1111111"; -- Apagar el segundo display
                else
                    SEG1 <= SEG_VALUES(index - 8); -- Dígito menos significativo
                    SEG2 <= SEG_VALUES(8);        -- Dígito más significativo (10 en Octal)
                end if;
        end case;

        -- Asignar salida combinada
        SEG <= SEG1 and SEG2; -- Salida combinada de segmentos
    end process;
end deco;
