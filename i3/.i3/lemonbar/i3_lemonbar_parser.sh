#!/bin/bash
#
# Input parser for i3 bar
# 14 ago 2015 - Electro7

# config
. $(dirname $0)/i3_lemonbar_config

# min init
irc_n_high=0
title="%{F${color_head} B${color_sec_b2}}${sep_right}%{F${color_head} B${color_sec_b2}%{T2} ${icon_prog} %{F${color_sec_b2} B-}${sep_right}%{F- B- T1}"

# parser
while read -r line ; do
  case $line in
    SYS*)
      # conky=, 0 = wday, 1 = mday, 2 = month, 3 = time, 4 = cpu, 5 = mem, 6 = disk /, 7 = disk /home, 8-9 = up/down wlan, 10-11 = up/down eth, 12-13=speed
      sys_arr=(${line#???})
      # date
      if [ ${res_w} -gt 1024 ]; then
        date="${sys_arr[0]} ${sys_arr[1]} ${sys_arr[2]}"
      else
        date="${sys_arr[1]} ${sys_arr[2]}"
      fi
      date="%{F${color_sec_b1}}${sep_left}%{F${color_icon} B${color_sec_b1}} %{T2}${icon_clock}%{F- T1} ${date}"
      # time
      time="%{F${color_head}}${sep_left}%{F${color_back} B${color_head}} ${sys_arr[3]} %{F- B-}"
      # cpu
      if [ ${sys_arr[4]} -gt ${cpu_alert} ]; then
        cpu_cback=${color_cpu}; cpu_cicon=${color_back}; cpu_cfore=${color_back};
      else
        cpu_cback=${color_sec_b1}; cpu_cicon=${color_icon}; cpu_cfore=${color_fore};
      fi
      cpu="%{F${cpu_cback}}${sep_left}%{F${cpu_cicon} B${cpu_cback}} %{T2}${icon_cpu}%{F${cpu_cfore} T1} ${sys_arr[4]}%"
      # mem
      mem="%{F${cpu_cicon}}${sep_l_left} %{T2}${icon_mem}%{F${cpu_cfore} T1} ${sys_arr[5]}"
      # disk /
      diskr="%{F${color_sec_b2}}${sep_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_hd}%{F- T1} ${sys_arr[6]}%"
      # disk home
      diskh="%{F${color_icon}}${sep_l_left} %{T2}${icon_home}%{F- T1} ${sys_arr[7]}%"
      # wlan
      #if [ "${sys_arr[8]}" == "down" ]; then
      #  wland_v="×"; wlanu_v="×";
      #  wlan_cback=${color_sec_b2}; wlan_cicon=${color_disable}; wlan_cfore=${color_disable};
      #else
      #  wland_v=${sys_arr[8]}K; wlanu_v=${sys_arr[9]}K;
      #  if [ ${wland_v:0:-3} -gt ${net_alert} ] || [ ${wlanu_v:0:-3} -gt ${net_alert} ]; then
      #    wlan_cback=${color_net}; wlan_cicon=${color_back}; wlan_cfore=${color_back};
      #  else
      #    wlan_cback=${color_sec_b2}; wlan_cicon=${color_icon}; wlan_cfore=${color_fore};
      #  fi
      #fi

	  if [ ${sys_arr[9]} -ne 0 ]; then
        wlan_cback=${color_net}; wlan_cicon=${color_back}; wlan_cfore=${color_back};
      else
        wlan_cback=${color_sec_b1}; wlan_cicon=${color_icon}; wlan_cfore=${color_fore};
	  fi
      wland="%{F${wlan_cback}}${sep_left}%{F${wlan_cicon} B${wlan_cback}} %{T2}${icon_dl}%{F${wlan_cfore} T1} ${sys_arr[8]}"
      #wlanu="%{F${wlan_cicon}}${sep_l_left} %{T2}${icon_ul}%{F${wlan_cfore} T1} ${wlanu_v}"
      # eth
      #if [ "${sys_arr[10]}" == "down" ]; then
      #  ethd_v="×"; ethu_v="×";
      #  eth_cback=${color_sec_b1}; eth_cicon=${color_disable}; eth_cfore=${color_disable};
      #else
      #  ethd_v=${sys_arr[10]}K; ethu_v=${sys_arr[11]}K;
      #  if [ ${ethd_v:0:-3} -gt ${net_alert} ] || [ ${ethu_v:0:-3} -gt ${net_alert} ]; then
      #    eth_cback=${color_net}; eth_cicon=${color_back}; eth_cfore=${color_back};
      #  else
      #    eth_cback=${color_sec_b1}; eth_cicon=${color_icon}; eth_cfore=${color_fore};
      #  fi
      #fi
      ethd="%{F${color_sec_b1}}${sep_left}%{F${color_back} B${color_sec_b1}} %{T2}${icon_dl}%{F${color_fore} T1} ${sys_arr[10]}"
      #ethu="%{F${eth_cicon}}${sep_l_left} %{T2}${icon_ul}%{F${eth_cfore} T1} ${ethu_v}"

      ;;
    VOL*)
      # Volume
      volv=${line#???}
      volv=${volv%?}
      vol="%{F${color_sec_b2}}${sep_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_vol}%{F- T1} ${volv}"
      ;;
    GMA*)
      # Gmail
      gmail="${line#???}"
      if [ "${gmail}" != "0" ]; then
        mail_cback=${color_mail}; mail_cicon=${color_back}; mail_cfore=${color_back}
      else
        mail_cback=${color_sec_b1}; mail_cicon=${color_icon}; mail_cfore=${color_fore}
      fi
      gmail="%{F${mail_cback}}${sep_left}%{F${mail_cicon} B${mail_cback}} %{T2}${icon_mail}%{F${mail_cfore} T1} ${gmail}"
      ;;
    MPD*)
      # Music
      mpd_arr=(${line#???})
      if [ -z "${line#???}" ]; then
        song="none";
      elif [ "${mpd_arr[0]}" == "error:" ]; then
        song="mpd off";
      else
        song="${line#???}";
      fi
      mpd="%{F${color_sec_b2}}${sep_left}%{B${color_sec_b2}}%{F${color_sec_b2}}${sep_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_music}%{F${color_fore} T1}  ${song}"
      ;;
    WSP*)
      # I3 Workspaces
      wsp="%{F${color_back} B${color_head}} %{T2}${icon_wsp}%{T1}"
      set -- ${line#???}
      while [ $# -gt 0 ] ; do
        case $1 in
         FOC*)
           wsp="${wsp}%{F${color_head} B${color_wsp}}${sep_right}%{F${color_back} B${color_wsp} T1} ${1#???} %{F${color_wsp} B${color_head}}${sep_right}"
           ;;
         INA*|URG*|ACT*)
           wsp="${wsp}%{F${color_disable} T1} ${1#???} "
           ;;
        esac
        shift
      done
      ;;
    WIN*)
      # window title
      title=$(xprop -id ${line#???} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
      title="%{F${color_head} B${color_sec_b2}}${sep_right}%{F${color_head} B${color_sec_b2}%{T2} ${icon_prog} %{F${color_sec_b2} B-}${sep_right}%{F- B- T1} ${title}"
      #title="%{F${color_head} B${color_sec_b2}}${sep_right}%{F${color_head} B${color_sec_b2} T2} ${icon_prog} %{F${color_sec_b2} B-}${sep_right}%{F- B- T1} ${title}"
      ;;
  BAT*)
	  # Battery readout:
	  #   [0] = integer part
	  #   [1] = charging status (D(ischarging), C(harging))
	  #   [2] = power level (F(ull), N(ormal), L(ow), C(ritical))
	  bat_arr=(${line#???})
	  bat_icons=($icon_battery)
	  ico="${bat_icons[$(((${bat_arr[0]}*(${#bat_icons[@]}-1))/100))]}"
	  bkg="${color_sec_b1}"
	  frg="${color_fore}"

	  if [[ ${bat_arr[2]} == "L" ]]; then
		  bkg="${color_warning}"
		  frg="${color_back}"
	  elif [[ ${bat_arr[2]} == "C" ]]; then
		  bkg="${color_critical}"
		  frg="${color_back}"
	  elif [[ ${bat_arr[2]} == "F" ]]; then
		  bkg="${c_green_d}"
		  frg="${c_white_l}"
	  fi

	  batamt="%{F${bkg}}${sep_left}%{B${bkg}} %{F${frg}} ${ico} ${bat_arr[0]}%%"

	  if [[ ${bat_arr[1]} == "C" ]]; then
		  batamt="%{F${color_fore}}${sep_left}%{F${color_back} B${color_fore}}${icon_charging}${batamt}"
	  fi
	  ;;

  esac

  # And finally, output
  printf "%s\n" "%{l}${wsp}${title} %{r}${mpd}${stab}${cpu}${stab}${mem}${stab}${diskr}${stab}${diskh}${stab}${wland}${vpn}${stab}${vol}${stab}${date}${stab}${time}"
done
