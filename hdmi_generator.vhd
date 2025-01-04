library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hdmi_generator is
	generic (
		-- Resolution
		h_res 	: natural := 720;
		v_res 	: natural := 480;

		-- Timings magic values (480p)
		h_sync	: natural := 61;
		h_fp	: natural := 58;
		h_bp	: natural := 18;

		v_sync	: natural := 5;
		v_fp	: natural := 30;
		v_bp	: natural := 9

	);
	port (
		i_clk  		: in std_logic;
    	i_reset_n 	: in std_logic;
    	o_hdmi_hs   : out std_logic;
    	o_hdmi_vs   : out std_logic;
    	o_hdmi_de   : out std_logic;
		
		o_pixel_en : out std_logic;
		o_pixel_address : out natural range 0 to (h_res * v_res - 1);
		
		o_x_counter : out natural range 0 to (h_res - 1);
		o_y_counter : out natural range 0 to (v_res - 1);
		o_pixel_pos_x : out natural range 0 to (h_res - 1);
		o_pixel_pos_y : out natural range 0 to (v_res - 1);
		o_new_frame : out std_logic	
		
  	);
end hdmi_generator;

architecture rtl of hdmi_generator is
	signal h_count : natural range 0 to h_res-1+h_fp+h_sync+h_bp :=0;
	signal v_count : natural range 0 to v_res-1+v_fp+v_sync+v_bp :=0;
	signal v_enable : std_logic :='0';
	signal h_act : std_logic :='0';
	signal v_act : std_logic :='0';
	signal v_hdmi_de : std_logic :='0';
	signal r_pixel_counter : natural range 0 to h_res * v_res - 1;
--	signal r_x_counter : natural range 0 to (h_res - 1);
--	signal r_y_counter : natural range 0 to (v_res - 1);
	
	begin 
		process(i_clk, i_reset_n)
		begin 
			if (i_reset_n = '0') then 
				h_count <=0;
				v_count <=0;
				o_hdmi_hs <= '1';
				o_hdmi_vs <= '1';
			elsif (rising_edge(i_clk)) then 
				if (h_count = h_res-1+h_fp+h_sync+h_bp) then 
					h_count <=0;
					o_hdmi_hs <= '1';
				elsif (h_count >= h_res-1+h_fp and h_count <= h_res-1+h_fp+h_sync) then 
					h_count <= h_count+1;
					o_hdmi_hs <= '0';
				else
					h_count <= h_count+1;
					o_hdmi_hs <= '1';
				end if;
				
				if (v_enable ='1' and v_count =v_res-1+v_fp+v_sync+v_bp) then 
					v_count <=0;
					o_hdmi_vs <= '1';
				elsif(v_enable = '1' and v_count >= v_res-1+v_fp and v_count <= v_res-1+v_fp+v_sync) then 
					v_count <= v_count+1;
					o_hdmi_vs <= '0';
				elsif( v_enable = '1') then
					v_count <= v_count +1;
					o_hdmi_vs <= '1';
				end if;
				
				if(h_act = '1' and v_act = '1') then
					o_hdmi_de <= '1';
					v_hdmi_de <= '1';
				else 
					o_hdmi_de <= '0';
					v_hdmi_de <= '0';
				end if;
				
				if (v_hdmi_de = '1') then 
					r_pixel_counter <= r_pixel_counter + 1;
				elsif(r_pixel_counter = h_res * v_res - 1) then
					r_pixel_counter <= 0;
				end if;
				
--				if(r_pixel_counter mod 179 = 0) then 
--					r_y_counter <= r_y_counter + 1;
--				end if;
				
			
				
			end if ;
			
		end process;
		
		v_enable<= '1' when (h_count = h_res-1+h_fp+h_sync+h_bp) else '0';
		h_act <= '1' when (h_count >= h_sync+h_bp and h_count <= h_res-1 - h_fp) else '0';
		v_act <= '1' when (v_count >= v_sync+v_bp and v_count <= v_res-1 - v_fp) else '0';
		o_pixel_address <= r_pixel_counter;
		o_pixel_pos_x <= r_pixel_counter mod (h_res-1);
		o_pixel_pos_y <= r_pixel_counter / (h_res-1);
end architecture rtl;
