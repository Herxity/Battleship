----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 11:52:19 AM
-- Design Name: 
-- Module Name: Blue background - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Blue_background is
    Port ( clk : in std_logic;
         rst : in std_logic;
         h_s: out std_logic;
         v_s : out std_logic;
         hcounter:out std_logic_vector(10 downto 0);
         vcounter:out std_logic_vector(9 downto 0);
         R: out std_logic_vector( 3 downto 0);
         G: out std_logic_vector( 3 downto 0);
         B: out std_logic_vector( 3 downto 0)
        );
end Blue_background;

architecture Behavioral of Blue_background is

    signal hcount : std_logic_vector(10 downto 0):= (others => '0');
    signal vcount : std_logic_vector(9 downto 0):= (others => '0');


begin
    process( clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                v_s <= '0';
                h_s <= '0';
                R <= "1111";  -- this makes it white
                G <= "1111";
                B <= "1111";
            else
                hcount <= std_logic_vector(unsigned(hcount) + 1);
                if (unsigned(hcount)) = 799 then
                    hcount <= (others => '0');
                    vcount <= std_logic_vector(unsigned(vcount) + 1);
                end if;
                if (unsigned(vcount)) = 524 then
                    vcount <= (others => '0');
                end if;
                if ((unsigned(hcount)) <= 639) and ((unsigned(vcount)) <= 479) then
                    if ((unsigned(vcount)) mod 91 = 0 or (unsigned(hcount)) mod 91 = 0) then
                        R <= "1111"; -- White Lines
                        G <= "1111";
                        B <= "1111";
                    else
                        R <= "0000";
                        G <= "0000";
                        B <= "1111"; -- Blue box
                    end if;
                    -- Draw letters
                    if ((unsigned(vcount)) >= 200) and ((unsigned(vcount)) <= 280) and (unsigned(hcount)) >= 200 and (unsigned(hcount)) <= 280 then
                        case vcount is
                            when 221 | 241 | 261 =>
                                case hcount is
                                    when 211 | 241 =>
                                        R <= "1111"; -- White 
                                        G <= "1111";
                                        B <= "1111";
                                    when 221 =>
                                        if (unsigned(hcount)) <= 241 then
                                            R <= "1111";
                                            G <= "1111";
                                            B <= "1111";
                                        end if;
                                    when 231 =>
                                        if (unsigned(hcount)) >= 211 then
                                            R <= "1111";
                                            G <= "1111";
                                            B <= "1111";
                                        end if;
                                    when 251 =>
                                        if (unsigned(hcount)) <= 241 then
                                            R <= "1111";
                                            G <= "1111";
                                            B <= "1111";
                                        end if;
                                    when 261 =>
                                        if (unsigned(hcount)) >= 211 then
                                            R <= "1111";
                                            G <= "1111";
                                            B <= "1111";
                                        end if;
                                    when 271 | 281 =>
                                        R <= "1111";
                                        G <= "1111";
                                        B <= "1111";
                                    when others =>
                                        R <= (others => '0');
                                        G <= (others => '0');
                                        B <= (others => '0');
                                end case;
                            when others =>
                                R <= (others => '0');
                                G <= (others => '0');
                                B <= (others => '0');
                        end case;
                    end if;
                else
                    R <= "0000";
                    G <= "0000";
                    B <= "0000";
                end if;
                if (unsigned(hcount)) = 639 and (unsigned(vcount)) = 479 then
                    h_s <= '1';
                    v_s <= '1';
                else
                    h_s <= '0';
                    v_s <= '0';
                end if;
            end if;
        end if;
    end process;
    hcount <= hcounter;
    vcount <= vcounter;
end Behavioral;