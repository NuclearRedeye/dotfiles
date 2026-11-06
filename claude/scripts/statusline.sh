#!/bin/sh
# Status line: model | context tokens | context % used | session cost | rate limits | cache.
input=$(cat)
echo "$input" | jq -r '
  def k: if . >= 1000 then ((. / 100 | round) / 10 | tostring) + "k" else tostring end;
  def money: . * 100 | round / 100 | tostring
    | if test("\\.\\d$") then . + "0" elif test("\\.") then . else . + ".00" end;
  # ANSI colours: green under 100k, amber under 200k, red from 200k
  def colour: if . < 100000 then "\u001b[32m" elif . < 200000 then "\u001b[38;5;214m" else "\u001b[31m" end;
  def reset: "\u001b[0m";
  # Rate limit %: green under 75, amber under 90, red from 90
  def limit_colour: if . < 75 then "\u001b[32m" elif . < 90 then "\u001b[38;5;214m" else "\u001b[31m" end;
  # Absent until the first API response, and only for Pro/Max subscribers
  def limit($label): if . == null then empty else round | "\(limit_colour)\($label): \(.)%\(reset)" end;
  # Cache time left: green, amber under 25% of TTL, red under 10% or cold
  def cache_colour($ttl): if . < $ttl * 0.1 then "\u001b[31m" elif . < $ttl * 0.25 then "\u001b[38;5;214m" else "\u001b[32m" end;
  def duration: if . >= 60 then "\(. / 60 | floor)m" else "\(.)s" end;
  # Absent until the first response; expires_at is null when nothing is cached
  def cache:
    if . == null or .expires_at == null then empty
    elif .warm | not then "\u001b[31mcache: cold\(reset)"
    else (if .ttl == "1h" then 3600 else 300 end) as $ttl
      | ([.expires_at - now, 0] | max | floor) as $left
      | "\($left | cache_colour($ttl))cache: \($left | duration)\(reset)"
    end;
  (.model.display_name // "Claude") as $m
  | (.context_window.total_input_tokens // 0) as $used
  | (.context_window.used_percentage // 0 | round) as $pct
  | (.cost.total_cost_usd // 0) as $cost
  | ([(.rate_limits.five_hour.used_percentage | limit("5h")),
      (.rate_limits.seven_day.used_percentage | limit("1w")),
      (.prompt_cache | cache)] | join(" | ")) as $extras
  | "\($m) | \($used | colour)\($used | k) tokens\(reset) | ctx: \($pct)% | $\($cost | money)"
    + (if $extras == "" then "" else " | \($extras)" end)
'
