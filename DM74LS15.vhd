library IEEE;
use IEEE.std_logic_1164.all;

--  Entity Declaration for DM74LS153 (Dual 4-to-1 MUX)
entity DM74LS153 is
    port (
        G1, G2 : in  std_logic;                       -- Active-LOW enables for MUX1 and MUX2
        A, B   : in  std_logic;                       -- Shared select lines
        C1, C2 : in  std_logic_vector(3 downto 0);    -- Data inputs for each multiplexer
        Y1, Y2 : out std_logic                        -- Outputs
    );
end entity DM74LS153;

--  Architecture 1: Dataflow model
architecture df of DM74LS153 is
    signal sControl1, sControl2 : std_logic_vector(3 downto 0);  -- One-hot select lines
begin
    -- Convert A,B into one-hot selection (used to index C1)
    sControl1 <= "0001" when A='0' and B='0' else
                 "0010" when A='1' and B='0' else
                 "0100" when A='0' and B='1' else
                 "1000";   -- A=1,B=1

    -- Same for second MUX
    sControl2 <= sControl1;

    -- MUX1 output (ignores G1 here — simplified model)
    with sControl1 select
        Y1 <= C1(0) when "0001",
              C1(1) when "0010",
              C1(2) when "0100",
              C1(3) when "1000",
              '0'   when others;   -- Should not occur

    -- MUX2 output
    with sControl2 select
        Y2 <= C2(0) when "0001",
              C2(1) when "0010",
              C2(2) when "0100",
              C2(3) when "1000",
              '0'   when others;
end architecture df;

--  Architecture 2: Behavioral model (with delays)
architecture behv of DM74LS153 is
begin

    -- MUX1 process - models propagation delay (22 ns)
    process(G1, A, B, C1)
        variable sel1 : std_logic_vector(2 downto 0); -- G1,B,A packed together
    begin
        sel1 := G1 & B & A; -- Combine enable + selects into one vector

        case sel1 is
            when "000" => Y1 <= C1(0) after 22 ns;   -- G1=0,B=0,A=0
            when "001" => Y1 <= C1(1) after 22 ns;   -- G1=0,B=0,A=1
            when "010" => Y1 <= C1(2) after 22 ns;   -- G1=0,B=1,A=0
            when "011" => Y1 <= C1(3) after 22 ns;   -- G1=0,B=1,A=1
            when others => Y1 <= '0';                -- G1=1 → forced LOW (disabled)
        end case;
    end process;
            
    -- MUX2 process - identical but uses G2 and C2
    process(G2, A, B, C2)
        variable sel2 : std_logic_vector(2 downto 0);
    begin
        sel2 := G2 & B & A;

        case sel2 is
            when "000" => Y2 <= C2(0) after 22 ns;
            when "001" => Y2 <= C2(1) after 22 ns;
            when "010" => Y2 <= C2(2) after 22 ns;
            when "011" => Y2 <= C2(3) after 22 ns;
            when others => Y2 <= '0';   -- Disabled state
        end case;
    end process;

end architecture behv;

--  Architecture 3: Structural model (using component MUX4)
architecture struct of DM74LS153 is

    -- Component declaration for a single 4:1 multiplexer
    component MUX4
        port (
            A, B, G  : in  std_logic;                  -- Select + active-low enable
            C        : in  std_logic_vector(3 downto 0); -- Data lines
            Y        : out std_logic
        );
    end component;

begin
    -- Instantiate first 4:1 multiplexer
    MUX1_INST: MUX4
        port map (
            A => A,
            B => B,
            G => G1,
            C => C1,
            Y => Y1
        );

    -- Instantiate second multiplexer
    MUX2_INST: MUX4
        port map (
            A => A,
            B => B,
            G => G2,
            C => C2,
            Y => Y2
        );
end architecture struct;
