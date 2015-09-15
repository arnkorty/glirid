class AddSeedToFrequencies < ActiveRecord::Migration
  def migrate direction
   if direction == :up 
     Frequency.create! [
       {name: '只执行一次', frequency_time: 0},
       {name: '30 分钟', frequency_time: 30 * 60},
       {name: '1 小时', frequency_time: 60 * 60},
       {name: '3 小时', frequency_time: 3 * 60 * 60},
       {name: '6 小时', frequency_time: 6 * 60 * 60},
       {name: '12 小时', frequency_time: 12 * 60 * 60},
       {name: '1 天', frequency_time: 24 * 60 * 60},
       {name: '7 天', frequency_time: 7 * 24 * 60 * 60},
       {name: '30 天', frequency_time: 30 * 24 * 60 * 60},
     ]
   end
  end
  def change
  end
end
