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

