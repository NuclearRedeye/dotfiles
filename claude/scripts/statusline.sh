#!/bin/sh
# Status line: model | context tokens | context % used | session cost.
input=$(cat)
echo "$input" | jq -r '
  def k: if . >= 1000 then ((. / 100 | round) / 10 | tostring) + "k" else tostring end;
  def money: . * 100 | round / 100 | tostring
    | if test("\\.\\d$") then . + "0" elif test("\\.") then . else . + ".00" end;
  (.model.display_name // "Claude") as $m
  | (.context_window.total_input_tokens // 0) as $used
  | (.context_window.used_percentage // 0 | round) as $pct
  | (.cost.total_cost_usd // 0) as $cost
  | "\($m) | \($used | k) tokens | ctx: \($pct)% | $\($cost | money)"
'
