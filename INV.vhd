--  Inverter Gate (INV)
entity INV is
    port (
        A : in  std_logic;   -- Input signal
        Y : out std_logic    -- Output = NOT A
    );
end entity INV;

--  Behavioral architecture with propagation delay
architecture behv of INV is
begin
    -- Output Y is the logical NOT of input A
    -- Propagation delay modeled as 4 ns
    Y <= not A after 4 ns;
end architecture behv;
