entity AND4 is
    port (A, B, C, D : in std_logic; Y : out std_logic);
end entity AND4;

architecture behv of AND4 is
begin
    Y <= (A and B and C and D) after 7 ns;
end architecture behv;

