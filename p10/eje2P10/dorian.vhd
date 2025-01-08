library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.BIN_BCD.ALL;      -- Se asume que bin_to_bcd(...) retorna 8 bits
use work.BIN_GRAY.ALL;
use work.BIN_EXCESO3.ALL;

entity comparador is
    Port (
        CLK : in std_logic;
        Dor : in STD_LOGIC_VECTOR (1 downto 0);  -- Selector para las conversiones
        Bre : in STD_LOGIC_VECTOR (3 downto 0);  -- Número en binario
        Alb : out STD_LOGIC_VECTOR (7 downto 0); -- Salida de 8 bits (LEDs)
        Mon : out STD_LOGIC_VECTOR (11 downto 0) -- Salida de 12 bits (Displays)
    );
end comparador;

architecture Behavioral of comparador is

    signal contador : std_logic := '0';
    -- Señal interna que alterna entre '0' y '1' en cada flanco de subida del reloj

begin

    ------------------------------------------------------------------------------
    -- Generación de la señal 'contador'
    ------------------------------------------------------------------------------
    process (CLK)
    begin
        if rising_edge(CLK) then
            contador <= not contador;
        end if;
    end process;


    ------------------------------------------------------------------------------
    -- Asignación de 'Alb' (8 bits) según 'Dor'
    ------------------------------------------------------------------------------
    process (Dor, Bre)
    begin
        case Dor is
        
            when "00" =>  
                -- Conversión a código Gray (4 bits + 4 bits = 8 bits)
                Alb <= "0000" & bin_to_gray(Bre);

            when "01" =>  
                -- Conversión a Exceso-3 (se asignan directamente 8 bits)
                case Bre is
                    when "0000" => Alb <= "00000011";
                    when "0001" => Alb <= "00000100";
                    when "0010" => Alb <= "00000101";
                    when "0011" => Alb <= "00000110";
                    when "0100" => Alb <= "00000111";
                    when "0101" => Alb <= "00001000";
                    when "0110" => Alb <= "00001001";
                    when "0111" => Alb <= "00001010";
                    when "1000" => Alb <= "00001011";
                    when "1001" => Alb <= "00001100";
                    when "1010" => Alb <= "01000011";
                    when "1011" => Alb <= "01000100";
                    when "1100" => Alb <= "01000101";
                    when "1101" => Alb <= "01000110";
                    when "1110" => Alb <= "01000111";
                    when "1111" => Alb <= "01001000";
                    when others => Alb <= "11111111";  -- 8 bits
                end case;

            when "10" =>
                -- Si quisieras mostrar BCD también en los LEDs, ajusta aquí.
                -- Por ahora, dejamos en cero (8 bits).
                Alb <= (others => '0');  -- "00000000"

            when "11" =>
                -- Si quisieras mostrar Octal también en los LEDs, ajusta aquí.
                -- Por ahora, dejamos en cero (8 bits).
                Alb <= (others => '0');  -- "00000000"

            when others =>
                -- Valor por defecto para Alb si 'Dor' no coincide
                Alb <= (others => '0');  -- "00000000"

        end case;
    end process;


    ------------------------------------------------------------------------------
    -- Control de 'Mon' (12 bits) para conversiones BCD y Octal
    ------------------------------------------------------------------------------
    process (Bre, Dor, contador)
        variable Bre_int : integer;
    begin
        Bre_int := to_integer(unsigned(Bre));

        -- ================================================
        -- Selector '10' = Conversión a BCD (en displays)
        -- ================================================
        if (Dor = "10") then
            if (contador = '0') then
                if (Bre_int <= 9) then 
                    -- "0111" = 4 bits, bin_to_bcd(...) = 8 bits => total 12 bits
                    Mon <= "0111" & bin_to_bcd(std_logic_vector(to_unsigned(Bre_int, 4)));
                else
                    Mon <= "0111" & bin_to_bcd(std_logic_vector(to_unsigned(Bre_int - 10, 4)));
                end if;
            else
                if (Bre_int >= 10) then
                    Mon <= "1011" & bin_to_bcd("0001");  
                    -- "1011" (4 bits) + "0001" (4 bits?) => OJO: 
                    -- si bin_to_bcd("0001") devuelve 8 bits, basta con "1011" + bin_to_bcd(...) = 12.
                    -- Ajusta según tu función bin_to_bcd.
                else
                    Mon <= "1011" & bin_to_bcd("0000");
                end if;
            end if;

        -- ================================================
        -- Selector '11' = Conversión a Octal (en displays)
        -- ================================================
        elsif (Dor = "11") then
            if (contador = '0') then
                if (Bre_int <= 7) then 
                    Mon <= "0111" & bin_to_bcd(std_logic_vector(to_unsigned(Bre_int, 4)));
                else
                    Mon <= "0111" & bin_to_bcd(std_logic_vector(to_unsigned(Bre_int - 8, 4)));
                end if;
            else
                if (Bre_int >= 8) then
                    Mon <= "1011" & bin_to_bcd("0001");
                else
                    Mon <= "1011" & bin_to_bcd("0000");
                end if;
            end if;

        -- ================================================
        -- Caso por defecto: apaga los displays
        -- ================================================
        else
            -- Cadena de 12 bits para apagar
            if (contador = '0') then
                Mon <= "011111111111";  -- 12 bits
            else 
                Mon <= "101111111111";  -- 12 bits
            end if;
        end if;
    end process;

end Behavioral;