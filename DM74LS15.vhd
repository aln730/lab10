library IEEE;
use IEEE.std_logic_1164.all;

-- ===============================
-- Part 0: Basic Components
-- ===============================

-- 1. Inverter
entity INV is
    port (A : in std_logic; Y : out std_logic);
end entity INV;

architecture behv of INV is
begin
    Y <= not A after 4 ns;
end architecture behv;

-- 2. 4-input AND gate
entity AND4 is
    port (A, B, C, D : in std_logic; Y : out std_logic);
end entity AND4;

architecture behv of AND4 is
begin
    Y <= A and B and C and D after 7 ns;
end architecture behv;

-- 3. 4-input OR gate
entity OR4 is
    port (A, B, C, D : in std_logic; Y : out std_logic);
end entity OR4;

architecture behv of OR4 is
begin
    Y <= A or B or C or D after 7 ns;
end architecture behv;

-- ===============================
-- Part 1: 4-to-1 Multiplexer (structural)
-- ===============================
entity MUX4 is
    port (
        A, B, G  : in  std_logic;
        C        : in  std_logic_vector(3 downto 0);
        Y        : out std_logic
    );
end entity MUX4;

architecture struct of MUX4 is
    component INV
        port (A : in std_logic; Y : out std_logic);
    end component;

    component AND4
        port (A, B, C, D : in std_logic; Y : out std_logic);
    end component;

    component OR4
        port (A, B, C, D : in std_logic; Y : out std_logic);
    end component;

    signal nA, nB, nG : std_logic;
    signal y0, y1, y2, y3 : std_logic;

begin
    -- Inverters
    U1: INV port map (A => A, Y => nA);
    U2: INV port map (A => B, Y => nB);
    U3: INV port map (A => G, Y => nG);

    -- AND gates
    AND0: AND4 port map (A => nG, B => nB, C => nA, D => C(0), Y => y0);
    AND1: AND4 port map (A => nG, B => nB, C => A,  D => C(1), Y => y1);
    AND2: AND4 port map (A => nG, B => B,  C => nA, D => C(2), Y => y2);
    AND3: AND4 port map (A => nG, B => B,  C => A,  D => C(3), Y => y3);

    -- OR gate
    ORMUX: OR4 port map (A => y0, B => y1, C => y2, D => y3, Y => Y);
end architecture struct;

-- ===============================
-- Part 2: DM74LS153 Entity
-- ===============================
entity DM74LS153 is
    port (
        G1, G2 : in  std_logic;                   -- Enable for MUX1 and MUX2
        A, B   : in  std_logic;                   -- Selection inputs
        C1, C2 : in  std_logic_vector(3 downto 0); -- Data inputs for MUX1 and MUX2
        Y1, Y2 : out std_logic                    -- Outputs
    );
end entity DM74LS153;

-- ===============================
-- Part 3: Dataflow Architecture
-- ===============================
architecture df of DM74LS153 is
begin
    -- First multiplexer
    with A & B select
        Y1 <= C1(0) when "00",
              C1(1) when "01",
              C1(2) when "10",
              C1(3) when "11",
              '0'   when others;

    -- Second multiplexer
    with A & B select
        Y2 <= C2(0) when "00",
              C2(1) when "01",
              C2(2) when "10",
              C2(3) when "11",
              '0'   when others;
end architecture df;

architecture behv of DM74LS153 is
begin
    -- First MUX
    process(G1, A, B, C1)
    begin
        if G1 = '1' then
            Y1 <= '0' after 22 ns;
        elsif (A='0' and B='0') then
            Y1 <= C1(0) after 22 ns;
        elsif (A='0' and B='1') then
            Y1 <= C1(1) after 22 ns;
        elsif (A='1' and B='0') then
            Y1 <= C1(2) after 22 ns;
        elsif (A='1' and B='1') then
            Y1 <= C1(3) after 22 ns;
        else
            Y1 <= '0' after 22 ns;
        end if;
    end process;

    -- Second MUX
    process(G2, A, B, C2)
    begin
        if G2 = '1' then
            Y2 <= '0' after 22 ns;
        elsif (A='0' and B='0') then
            Y2 <= C2(0) after 22 ns;
        elsif (A='0' and B='1') then
            Y2 <= C2(1) after 22 ns;
        elsif (A='1' and B='0') then
            Y2 <= C2(2) after 22 ns;
        elsif (A='1' and B='1') then
            Y2 <= C2(3) after 22 ns;
        else
            Y2 <= '0' after 22 ns;
        end if;
    end process;
end architecture behv;


-- ===============================
-- Part 5: Structural Architecture
-- ===============================
architecture struct of DM74LS153 is
    component MUX4
        port (
            A, B, G : in  std_logic;
            C       : in  std_logic_vector(3 downto 0);
            Y       : out std_logic
        );
    end component;
begin
    -- Instantiate first MUX
    MUX1_INST: MUX4
        port map (A => A, B => B, G => G1, C => C1, Y => Y1);

    -- Instantiate second MUX
    MUX2_INST: MUX4
        port map (A => A, B => B, G => G2, C => C2, Y => Y2);
end architecture struct;
