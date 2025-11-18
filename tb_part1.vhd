library IEEE;
use IEEE.std_logic_1164.all;

entity tb_part1_testset2 is
end tb_part1_testset2;

architecture tb of tb_part1_testset2 is

    -- Testbench signals
    signal G1, G2 : std_logic := '0';
    signal A, B   : std_logic := '0';
    signal C1, C2 : std_logic_vector(3 downto 0) := (others => '0');

    -- Outputs for each architecture
    signal Y1_df,  Y2_df  : std_logic;
    signal Y1_behv, Y2_behv : std_logic;
    signal Y1_struct, Y2_struct : std_logic;

begin

    --------------------------------------------------------------------
    -- 3 INSTANCES IN PARALLEL
    --------------------------------------------------------------------
    dut_df: entity work.DM74LS153(df)
        port map (
            G1 => G1,
            G2 => G2,
            A  => A,
            B  => B,
            C1 => C1,
            C2 => C2,
            Y1 => Y1_df,
            Y2 => Y2_df
        );

    dut_behv: entity work.DM74LS153(behv)
        port map (
            G1 => G1,
            G2 => G2,
            A  => A,
            B  => B,
            C1 => C1,
            C2 => C2,
            Y1 => Y1_behv,
            Y2 => Y2_behv
        );

    dut_struct: entity work.DM74LS153(struct)
        port map (
            G1 => G1,
            G2 => G2,
            A  => A,
            B  => B,
            C1 => C1,
            C2 => C2,
            Y1 => Y1_struct,
            Y2 => Y2_struct
        );

    --------------------------------------------------------------------
    -- STIMULUS PROCESS: Test Set 2
    --------------------------------------------------------------------
    stim_proc : process
    begin
        -- Active G, constant data C1/C2 = 1010
        G1 <= '0'; G2 <= '0';
        C1 <= "1010"; C2 <= "1010";

        A <= '0'; B <= '0'; wait for 100 ns;
        A <= '1'; B <= '0'; wait for 100 ns;
        A <= '0'; B <= '1'; wait for 100 ns;
        A <= '1'; B <= '1'; wait for 100 ns;

        -- Change data to C1/C2 = 0101
        C1 <= "0101"; C2 <= "0101";

        A <= '0'; B <= '0'; wait for 100 ns;
        A <= '1'; B <= '0'; wait for 100 ns;
        A <= '0'; B <= '1'; wait for 100 ns;
        A <= '1'; B <= '1'; wait for 100 ns;

        wait;  -- End simulation
    end process;

end tb;