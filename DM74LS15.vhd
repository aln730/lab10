library IEEE;
use IEEE.std_logic_1164.all;

-- ===============================
-- Entity Declaration
-- ===============================
entity DM74LS153 is
    port (
        G1, G2 : in  std_logic;                  -- Enable for MUX1 and MUX2
        A, B   : in  std_logic;                  -- Selection inputs
        C1, C2 : in  std_logic_vector(3 downto 0); -- Data inputs for MUX1 and MUX2
        Y1, Y2 : out std_logic                   -- Outputs for MUX1 and MUX2
    );
end entity DM74LS153;

-- ===============================
-- Part 2: Dataflow Architecture
-- ===============================
architecture df of DM74LS153 is
begin
    -- First multiplexer (dataflow)
    with A & B select
        Y1 <= C1(0) when "00",
              C1(1) when "01",
              C1(2) when "10",
              C1(3) when "11",
              '0'   when others;

    -- Second multiplexer (dataflow)
    with A & B select
        Y2 <= C2(0) when "00",
              C2(1) when "01",
              C2(2) when "10",
              C2(3) when "11",
              '0'   when others;
end architecture df;

-- ===============================
-- Part 3: Behavioral Architecture
-- ===============================
architecture behv of DM74LS153 is
begin
    -- First multiplexer (behavioral)
    process(G1, A, B, C1)
    begin
        if G1 = '1' then
            Y1 <= '0' after 22 ns;
        else
            case A & B is
                when "00" => Y1 <= C1(0) after 22 ns;
                when "01" => Y1 <= C1(1) after 22 ns;
                when "10" => Y1 <= C1(2) after 22 ns;
                when "11" => Y1 <= C1(3) after 22 ns;
                when others => Y1 <= '0' after 22 ns;
            end case;
        end if;
    end process;

    -- Second multiplexer (behavioral)
    process(G2, A, B, C2)
    begin
        if G2 = '1' then
            Y2 <= '0' after 22 ns;
        else
            case A & B is
                when "00" => Y2 <= C2(0) after 22 ns;
                when "01" => Y2 <= C2(1) after 22 ns;
                when "10" => Y2 <= C2(2) after 22 ns;
                when "11" => Y2 <= C2(3) after 22 ns;
                when others => Y2 <= '0' after 22 ns;
            end case;
        end if;
    end process;
end architecture behv;

-- ===============================
-- Part 4: Structural Architecture
-- ===============================
architecture struct of DM74LS153 is

    -- ===============================
    -- Component Declarations
    -- ===============================
    component INV
        port (A : in std_logic; Y : out std_logic);
    end component;

    component AND4
        port (A, B, C, D : in std_logic; Y : out std_logic);
    end component;

    component OR4
        port (A, B, C, D : in std_logic; Y : out std_logic);
    end component;

    component MUX4
        port (
            A, B, G  : in  std_logic;
            C        : in  std_logic_vector(3 downto 0);
            Y        : out std_logic
        );
    end component;

begin
    -- Instantiate first MUX
    MUX1_INST: MUX4
        port map (
            A => A,
            B => B,
            G => G1,
            C => C1,
            Y => Y1
        );

    -- Instantiate second MUX
    MUX2_INST: MUX4
        port map (
            A => A,
            B => B,
            G => G2,
            C => C2,
            Y => Y2
        );

end architecture struct;
