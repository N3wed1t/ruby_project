require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

time_domain = {
  late_night: { count: 0, time_range: '00:00 -> 05:59' },
  morning: { count: 0, time_range: '06:00 -> 11:59' },
  afternoon: { count: 0, time_range: '12:00 -> 17:59' },
  night: { count: 0, time_range: '18:00 -> 23:59' }
}

def largest_hash_key(hash)
  hash.max_by { |_k, v| v }
end

def largest_hash_count(hash)
  count_array = []
  hash.each { |value| count_array.push(value[1][:count]) }
  hash.select { |_key, data| data[:count] == count_array.max }
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phonenumber(phonenumber)
  phone = phonenumber.gsub(/[-() .]/, '')
  if phone.length == 10
    phone
  elsif phone.length == 11 && phone[0] == 1
    phone.split('').drop(1).join
  else
    'bad number'
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(', ')
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def time_counter(times, time_rank)
  times.each do |time|
    if time.to_i.between?(0, 5)
      time_rank[:late_night][:count] += 1
    elsif time.to_i.between?(6, 11)
      time_rank[:morning][:count] += 1
    elsif time.to_i.between?(12, 17)
      time_rank[:afternoon][:count] += 1
    elsif time.to_i.between?(18, 23)
      time_rank[:night][:count] += 1
    end
  end
end

def time_ranking(times, time_rank)
  time_counter(times, time_rank)
  time_rank.each { |value| puts "#{value[0]} total #{value[1][:count]} time range = #{value[1][:time_range]}" }
  largest_count = largest_hash_count(time_rank)
  largest_count_key = largest_count.keys[0]
  largest_count_time = largest_count[largest_count_key][:time_range]
  puts "The time most people register is #{largest_count_key.to_s.gsub(':', '')} by the time of #{largest_count_time}"
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

# template_letter = File.read('form_letter.erb')
# erb_template = ERB.new template_letter
time = []
date = []
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  # legislators = legislators_by_zipcode(zipcode)
  phone = clean_phonenumber(row[:homephone])
  time.push(Time.parse(row[:regdate].split[1]).hour)
  date.push(Time.strptime(row[:regdate].split[0], '%m/%d/%y').strftime('%A'))
  # form_letter = erb_template.result(binding)

  # save_thank_you_letter(id,form_letter)
  # puts "#{id} #{name} #{zipcode} #{phone}"
end
def date_counter(date)
  date.each_with_object(Hash.new(0)) do |sum, total|
    total[sum] += 1
  end
end
time_ranking(time, time_domain)
date_usage = date_counter(date)
largest_date = largest_hash_key(date_usage)
puts "#{largest_date[0]} is the most register day of the week! by #{largest_date[1]} total"
