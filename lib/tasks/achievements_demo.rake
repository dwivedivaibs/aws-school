# Sample data for the Achievements pages (development only).
#
#   bundle exec rails achievements:demo        # load sample students + achievements
#   bundle exec rails achievements:demo_clear  # remove only the sample data
#
# Sample students have admission numbers starting with "DEMO-"; sample team /
# school-wide entries are matched by exact title, so clearing never touches
# real records.
namespace :achievements do
  DEMO_PREFIX = "DEMO-".freeze
  # Sample entries that have no student (team / school-wide news), matched by exact title.
  DEMO_UNLINKED_TITLES = [
    "Inter School Football Tournament",
    "CBSE Class X Result 2025-26",
    "Model United Nations – Etawah Summit 2025",
    "Inter School Group Singing Competition",
  ].freeze

  def demo_guard!
    abort "Refusing to run outside development." unless Rails.env.development?
  end

  def demo_img(name)
    File.open(Rails.root.join("app/assets/images/#{name}.jpg"))
  end

  def demo_clear!
    ids = Student.where("admission_no LIKE ?", "#{DEMO_PREFIX}%").pluck(:id)
    Achievement.where(student_id: ids).destroy_all
    Achievement.where("title LIKE ?", "%").destroy_all
    Student.where(id: ids).destroy_all
  end

  desc "Load sample students and achievements (development only)"
  task demo: :environment do
    demo_guard!
    demo_clear!

    s = {}
    [
      ["ananya", "Ananya Verma",   "8th",  "A", "Blue",   "15s"],
      ["rohit",  "Rohit Yadav",    "10th", "B", "Red",    nil],
      ["sneha",  "Sneha Gupta",    "9th",  "A", "Green",  "21s"],
      ["aditya", "Aditya Rajput",  "12th", "C", "Yellow", nil],
      ["kavya",  "Kavya Mishra",   "11th", "A", "Blue",   "23s"],
      ["arjun",  "Arjun Singh",    "6th",  "B", "Red",    nil],
      ["priya",  "Priya Chauhan",  "10th", "A", "Green",  nil],
    ].each_with_index do |(key, name, klass, section, house, photo), i|
      attrs = { name: name, student_class: klass, section: section, house: house, admission_no: "#{DEMO_PREFIX}#{i + 1}" }
      attrs[:photo] = demo_img(photo) if photo
      s[key] = Student.create!(attrs)
    end
    s["vikas"] = Student.create!(name: "Vikas Tomar", is_alumni: true, passing_year: "2021",
                                 admission_no: "#{DEMO_PREFIX}99", bio: "Batch of 2021, now at IIT Kanpur.")

    rows = [
      # ---- Sports ----
      { student: s["ananya"], title: "Khelo UP Swimming Competition", category: "sports", level: "state", position: "gold",
        event_date: "2026-01-27", is_featured: true, event_photo: "18", images: %w(17 19),
        description: "<p>Aristotle World School proudly congratulates <strong>Ananya Verma</strong> from VIII A for her remarkable feat in the Khelo UP Swimming Competition, held at Lucknow from 27th to 31st January, 2026.</p><p>Ananya won <strong>5 Gold Medals</strong> along with the Individual Championship.</p><p>Indeed a cherished achievement and many more on the way for Ananya.</p>" },
      { team_name: "U-14 Football Team", title: "Inter School Football Tournament", category: "sports",
        level: "district", position: "silver", event_date: "2025-11-12", event_photo: "15" },
      { student: s["rohit"], title: "District Chess Championship", category: "sports", level: "district",
        position: "bronze", event_date: "2025-09-05" },
      { student: s["arjun"], title: "CBSE Cluster Athletics Meet – 100m Sprint", category: "sports", level: "inter_school",
        position: "gold", event_date: "2025-10-18", event_photo: "24",
        description: "<p>Arjun Singh of Class VI B clinched the <strong>Gold Medal in the 100m sprint</strong> (Under-12) at the CBSE Cluster Athletics Meet held at Kanpur.</p><p>His speed and determination made the whole school proud.</p>" },

      # ---- Academic ----
      { title: "CBSE Class X Result 2025-26", category: "academic", event_date: "2026-05-13",
        event_photo: "20", is_featured: true,
        description: "<p>Aristotle World School proudly celebrates a <strong>100% result</strong> in the CBSE Class X Board Examinations 2025-26, with an impressive school average of 87.4%.</p><p>Special congratulations to our top performers:</p><ol><li>Priya Chauhan – 97.2%</li><li>Rohit Yadav – 96.4%</li><li>Sneha Gupta – 94.8%</li></ol><p>This success reflects the hard work of our students, the support of their parents and the commitment of our faculty.</p>" },
      { student: s["priya"], title: "CBSE Class X Board Examination – School Topper", category: "academic", level: "school",
        position: "gold", score: "97.2%", event_date: "2026-05-13" },
      { student: s["kavya"], title: "National Science Olympiad (SOF)", category: "academic", level: "national",
        position: "merit", event_date: "2025-12-10", event_photo: "22",
        description: "<p>Kavya Mishra of Class XI A secured an <strong>All India Rank of 112</strong> in the National Science Olympiad conducted by the Science Olympiad Foundation, earning a Medal of Distinction.</p>" },

      # ---- Art & Craft ----
      { student: s["sneha"], title: "Poster Making Competition – “Say No to Plastic”", category: "art_craft", level: "inter_school",
        position: "gold", event_date: "2025-11-20", event_photo: "26", images: %w(25),
        description: "<p>Sneha Gupta of Class IX, Aristotle World School, emerged as a shining example of creativity by clinching the <strong>First Prize</strong> at the inter-school poster-making competition organised in Etawah.</p><p>Amidst enthusiastic participation from several schools, her compelling artwork on “Say No to Plastic” captivated the judges.</p><p>Heartiest congratulations to Sneha and the Art Department for this proud achievement.</p>" },
      { student: s["arjun"], title: "National Level Drawing Competition 2025-26", category: "art_craft", level: "national",
        position: "special", event_date: "2026-02-08" },

      # ---- Literary ----
      { title: "Model United Nations – Etawah Summit 2025", category: "literary", level: "district",
        event_date: "2025-10-16", event_photo: "32", images: %w(33 34),
        description: "<p>The young and enterprising delegates of Aristotle World School attended the Etawah Model United Nations Summit 2025. The three-day conference saw <strong>40 of our students</strong> from classes VI–XII take part alongside more than 600 students from across the region.</p><p>Students solved real-life problems in simulations of the UN and the Parliament across 12 committees.</p><p>Our delegates won <strong>2 Best Delegate</strong> and <strong>3 Honourable Mention</strong> awards.</p>" },
      { student: s["kavya"], title: "Inter School English Debate", category: "literary", level: "inter_school",
        position: "silver", event_date: "2025-08-22" },

      # ---- Music & Dance ----
      { student: s["sneha"], title: "State Level Kathak Competition", category: "music_dance", level: "state",
        position: "silver", event_date: "2026-01-02", event_photo: "28", is_featured: true,
        description: "<p>Aristotle World School proudly celebrates Sneha Gupta, Class IX, for securing <strong>Second Position</strong> at the State Level Classical Dance Competition held at Lucknow on 02 January 2026.</p><p>Sneha competed in the Junior Category of Indian Classical Dance – Kathak and presented a captivating solo performance.</p>" },
      { team_name: "School Choir", title: "Inter School Group Singing Competition", category: "music_dance",
        level: "inter_school", position: "gold", event_date: "2025-12-05", event_photo: "29" },

      # ---- Alumni ----
      { student: s["vikas"], title: "Cleared JEE Advanced 2025 – Admitted to IIT Kanpur", category: "alumni", level: "national",
        event_date: "2025-06-10", event_photo: "35",
        description: "<p>Aristotle World School beams with pride as it celebrates its alumnus <strong>Vikas Tomar</strong> (Batch of 2021), who cleared JEE Advanced 2025 and secured admission to the <strong>Indian Institute of Technology, Kanpur</strong>.</p><p>An inspiring journey of hard work and perseverance for all our students.</p>" },
    ]

    rows.each do |r|
      r = r.dup
      photo  = r.delete(:event_photo)
      extras = r.delete(:images) || []
      a = Achievement.new(r.merge(event_date: r[:event_date] && Date.parse(r[:event_date])))
      a.event_photo = demo_img(photo) if photo
      extras.each_with_index { |img, i| a.images.build(image: demo_img(img), position: i) }
      a.save!
    end

    puts "Loaded #{Student.where('admission_no LIKE ?', "#{DEMO_PREFIX}%").count} sample students and #{rows.size} sample achievements."
    puts "Open http://localhost:3000/achievements"
  end

  desc "Remove the sample achievements data (development only)"
  task demo_clear: :environment do
    demo_guard!
    demo_clear!
    puts "Sample achievements data removed."
  end
end
