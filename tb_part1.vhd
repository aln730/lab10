library IEEE;
use IEEE.std_logic_1164.all;


entity tb_DM74LS153 is
end entity;

architecture sim of tb_DM74LS153 is


    signal G1, G2 : std_logic := '0';
    signal A, B   : std_logic := '0';
    signal C1, C2 : std_logic_vector(3 downto 0) := (others => '0');
    signal Y1_df, Y2_df : std_logic;
    signal Y1_behv, Y2_behv : std_logic;
    signal Y1_struct, Y2_struct : std_logic;

begin

    U_df : entity work.DM74LS153(df)
        port map (
            G1 => G1, G2 => G2, A => A, B => B, 
            C1 => C1, C2 => C2, 
            Y1 => Y1_df, Y2 => Y2_df
        );

    U_behv : entity work.DM74LS153(behv)
        port map (
            G1 => G1, G2 => G2, A => A, B => B, 
            C1 => C1, C2 => C2, 
            Y1 => Y1_behv, Y2 => Y2_behv
        );

    U_struct : entity work.DM74LS153(struct)
        port map (
            G1 => G1, G2 => G2, A => A, B => B, 
            C1 => C1, C2 => C2, 
            Y1 => Y1_struct, Y2 => Y2_struct
        );


    stimulus: process
    begin
        -- ---- Test Set 1:
        G1 <= '0'; G2 <= '0';
        A <= '0'; B <= '0';

        C1 <= "1110"; C2 <= "1110"; wait for 100 ns;

        C1 <= "0001"; C2 <= "0001"; wait for 100 ns;
      
        C1 <= "1101"; C2 <= "1101"; wait for 100 ns;
      
        C1 <= "0010"; C2 <= "0010"; wait for 100 ns;

        
        A <= '0'; B <= '1';
       
        C1 <= "1011"; C2 <= "1011"; wait for 100 ns;
     
        C1 <= "0100"; C2 <= "0100"; wait for 100 ns;
      
        C1 <= "0111"; C2 <= "0111"; wait for 100 ns;
        
        C1 <= "1000"; C2 <= "1000"; wait for 100 ns;

        -- ---- Test Set 2:
        C1 <= "1010"; C2 <= "1010";  
        G1 <= '0'; G2 <= '0';

      
        A <= '0'; B <= '0'; wait for 100 ns;
        A <= '1'; B <= '0'; wait for 100 ns;
        A <= '0'; B <= '1'; wait for 100 ns;
        A <= '1'; B <= '1'; wait for 100 ns;
        A <= '0'; B <= '0'; wait for 100 ns;
        A <= '1'; B <= '0'; wait for 100 ns;
        A <= '0'; B <= '1'; wait for 100 ns;
        A <= '1'; B <= '1'; wait for 100 ns;

        -- ---- Test Set 3:
        G1 <= '1'; G2 <= '1';

        A <= '0'; B <= '0'; wait for 100 ns;
        A <= '1'; B <= '0'; wait for 100 ns;
        A <= '0'; B <= '1'; wait for 100 ns;
        A <= '1'; B <= '1'; wait for 100 ns;


        wait;
    end process stimulus;

end architecture sim;
