
# SCOPE DATABASES

puts "loading scope_databases..."

ScopeDatabase.delete_all
open("#{Rails.root}/db/data/scope_databases.txt") do |filehandle|
  filehandle.read.each_line do |line|
    code, name = line.chomp.split("|")
    ScopeDatabase.create!(:name => name, :code => code) if name.length > 0
  end
end

puts "loaded #{ScopeDatabase.count} scope_databases"


# SCOPE QUICK SETS

puts "loading scope_quicksets..."

ScopeQuickSet.delete_all
open("#{Rails.root}/db/data/scope_quick_sets.txt") do |filehandle|
  filehandle.read.each_line do |line|
    name = line.chomp
    ScopeQuickSet.create!(:name => name) if name.length > 0
  end
end

puts "loaded #{ScopeQuickSet.count} scope_quicksets"



# SCOPE SUBJECTS

puts "loading scope_subjects..."

ScopeSubject.delete_all
open("#{Rails.root}/db/data/scope_subjects.txt") do |filehandle|
  filehandle.read.each_line do |line|
    name = line.chomp
    ScopeSubject.create!(:name => name) if name.length > 0
  end
end

puts "loaded #{ScopeSubject.count} scope_subjects"


# SCOPE SUBCATEGORIES

puts "loading scope_subcategories..."

ScopeSubcategory.delete_all
open("#{Rails.root}/db/data/scope_subcategories.txt") do |filehandle|
  filehandle.read.each_line do |line|
    subject_name, name = line.chomp.split("|")
    # puts "subject_name=[#{subject_name}] name=[#{name}]"
    if name && subject_name && subject_name.length > 0 && name.length > 0
      subject = ScopeSubject.where(name: subject_name).first
      raise "subject_name #{subject_name} not found in ScopeSubjects" unless subject
      ScopeSubcategory.create!(:name => name, :scope_subject_id => subject.id)
    end
  end
end

puts "loaded #{ScopeSubcategory.count} scope_subcategories"



