----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 05:51:51 PM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pixel_pusher is
    Port ( clk, en,vid :in std_logic;
         hcount,vcount:in std_logic_vector(9 downto 0);
         R,B: out std_logic_vector(4 downto 0);
         G: out std_logic_vector( 5 downto 0);
         Rin,Bin: in std_logic_vector(4 downto 0);
         Gin: in std_logic_vector( 5 downto 0)
        );
end pixel_pusher;

architecture Behavioral of pixel_pusher is
    signal hcounter,vcounter: std_logic_vector(9 downto 0):= (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' and vid = '1' then
                if (unsigned(hcounter) <= 599) and (unsigned(vcounter) <= 479) then
                    if (unsigned(vcounter) mod 80 = 0 or unsigned(hcounter) mod 100 = 0) then
                        R <= "11111"; -- White Lines
                        G <= "111111";
                        B <= "11111";
                    else
                        R <= Rin;
                        G <= Gin;
                        B <= Bin; -- Blue box
                    end if;
                else
                    R <= (others => '0');
                    G <= (others => '0');
                    B <= (others => '0');
                end if;
            end if;
        end if;
    end process;

    hcounter <= hcount;
    vcounter <= vcount;
end Behavioral;
