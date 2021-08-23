
#!/usr/bin/env bash

output_id=$(pacmd list-source-outputs | grep -B18 'media.name *= *"Loopback to null-sink-microphone-200ms-de-latence"' | grep -Po '(?<=index: )[0-9]+(?= *$)')
blue_snowflake_mic_name=$(pacmd list-sources | grep -B52 'device.description *= *"Blue Snowflake Mono"' | grep -Po '(?<=name: <).*(?=>)')

pacmd move-source-output $output_id $blue_snowflake_mic_name

# vim: set sts=2 ts=2 sw=2 tw=120 et :

