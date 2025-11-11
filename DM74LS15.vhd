library ieee;
use ieee.std_logic_1164.ALL;

entity DM74LS153 is
    port (
        -- Select inputs
        A   : in  std_logic;
        B   : in  std_logic;
        
        -- Enable inputs
        G1  : in  std_logic;
        G2  : in  std_logic;
        
        -- Data inputs for each multiplexer
        C1  : in  std_logic_vector(3 downto 0);
        C2  : in  std_logic_vector(3 downto 0);
        
        -- Outputs
        Y1  : out std_logic;
        Y2  : out std_logic
    );
end entity DM74LS153;

architecture df of DM74LS153 is
    -- Internal control signals
    signal sControl1, sControl2 : std_logic_vector(2 downto 0);
begin
    -- Create control signals for each multiplexer
    sControl1 <= G1 & B & A;
    sControl2 <= G2 & B & A;

    -- Model of the first multiplexer
    with sControl1 select
        Y1 <= C1(0) when "000",
              C1(1) when "001",
              C1(2) when "010",
              C1(3) when "011",
              '0'   when others;  -- disabled or undefined

    -- Model of the second multiplexer
    with sControl2 select
        Y2 <= C2(0) when "000",
              C2(1) when "001",
              C2(2) when "010",
              C2(3) when "011",
              '0'   when others;  -- disabled or undefined
end architecture df;

architecture behv of DM74LS153 is
begin

    process (A, B, G1, C1)
    begin
        if G1 = '0' then  -- enabled
            case (B & A) is
                when "00" => Y1 <= C1(0) after 22 ns;
                when "01" => Y1 <= C1(1) after 22 ns;
                when "10" => Y1 <= C1(2) after 22 ns;
                when "11" => Y1 <= C1(3) after 22 ns;
                when others => Y1 <= '0' after 22 ns;
            end case;
        else
            Y1 <= '0' after 22 ns;  -- disabled
        end if;
    end process;


    process (A, B, G2, C2)
    begin
        if G2 = '0' then  -- enabled
            case (B & A) is
                when "00" => Y2 <= C2(0) after 22 ns;
                when "01" => Y2 <= C2(1) after 22 ns;
                when "10" => Y2 <= C2(2) after 22 ns;
                when "11" => Y2 <= C2(3) after 22 ns;
                when others => Y2 <= '0' after 22 ns;
            end case;
        else
            Y2 <= '0' after 22 ns;  -- disabled
        end if;
    end process;

end architecture behv;

architecture struct of DM74LS153 is
    component MUX4
        port (
            A, B, G  : in  std_logic;
            C        : in  std_logic_vector(3 downto 0);
            Y        : out std_logic
        );
    end component;
begin
    -- First multiplexer
    MUX1: MUX4 port map (A => A, B => B, G => G1, C => C1, Y => Y1);

    -- Second multiplexer
    MUX2: MUX4 port map (A => A, B => B, G => G2, C => C2, Y => Y2);
end architecture struct;




