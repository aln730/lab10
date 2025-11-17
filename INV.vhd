entity INV is
    port (A : in std_logic; Y : out std_logic);
end entity INV;

architecture behv of INV is
begin
    Y <= not A after 4 ns;
end architecture behv;

