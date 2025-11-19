library ieee;
use ieee.std_logic_1164.all;

--  4-Input OR Gate (OR4)
entity OR4 is
    port (
        A, B, C, D : in  std_logic;   -- Four input signals
        Y          : out std_logic    -- Output = A OR B OR C OR D
    );
end entity OR4;
    
--  Behavioral architecture with propagation delay
architecture behv of OR4 is
begin
    -- Output Y goes HIGH if any of A, B, C, or D is '1'
    -- Includes a modeled propagation delay of 7 ns
    Y <= (A or B or C or D) after 7 ns;
end architecture behv;
