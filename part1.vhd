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

