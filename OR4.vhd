library ieee ;
use ieee . std_logic_1164 . all ;

entity OR4 is
    port (A, B, C, D : in std_logic; Y : out std_logic);
end entity OR4;

architecture behv of OR4 is
begin
    Y <= (A or B or C or D) after 7 ns;
end architecture behv;

