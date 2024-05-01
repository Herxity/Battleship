----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2024 07:25:12 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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

entity vga_ctrl is
    Port ( clk, en: in std_logic;
     vid,vs,hs: out std_logic;
     hcount,vcount:out std_logic_vector(9 downto 0)
        );
end vga_ctrl;


architecture Behavioral of vga_ctrl is

    signal hcounter, vcounter: std_logic_vector(9 downto 0):= (others => '0');
  
begin
process(clk)
begin

    if(rising_edge(clk)) then
        if(en = '1') then
            if( unsigned(hcounter) < 799) then
                hcounter <= std_logic_vector(unsigned(hcounter) + 1);
            elsif (unsigned(hcounter) = 799)then
                hcounter <= (others => '0');
            end if;
            if (unsigned(hcounter) = 0) and (unsigned(vcounter) < 524) then
                vcounter<= std_logic_vector(unsigned(vcounter) + 1);
            elsif (unsigned(vcounter) = 524) then
                vcounter <= (others => '0');
            end if;
        end if;
        if (unsigned(vcounter) < 639) and (unsigned(vcounter) < 479) then
            vid <= '1';
        else
            vid <= '0';
        end if;
        if (unsigned(hcounter) > 656) and (unsigned(hcounter) < 751)then
            hs <= '0';
        else
            hs <= '1';
        end if;
        if (unsigned(vcounter) > 490) and (unsigned(vcounter) < 491)then
            vs <= '0';
        else
            vs <= '1';
        end if;
    end if;
    hcount <= hcounter;
    vcount <= vcounter;
    end process;




end Behavioral;
