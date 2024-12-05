rules_part, page_updates_part = STDIN.read.split("\n\n")

rules = rules_part.split("\n").map { |line| line.split('|').map(&:to_i) }
page_updates = page_updates_part.split("\n").map { |line| line.split(',').map(&:to_i) }

class Solution
  def initialize(rules, page_updates)
    @page_updates = page_updates
    @smaller_than = {}
    rules.each do |a, b|
      @smaller_than[a] ||= []
      @smaller_than[a] << b
    end
  end

  def call
    puts result(@page_updates.filter { |pages| correct_order?(pages) })
    puts result(fix_order(@page_updates.reject { |pages| correct_order?(pages) }))
  end

  private

  def correct_order?(pages)
    pages.each_cons(2).all? { |a, b| @smaller_than[a]&.include?(b) }
  end

  def fix_order(page_updates)
    page_updates.map do |pages|
      pages.sort { |a, b| @smaller_than[a]&.include?(b) ? -1 : 1 }
    end
  end

  def result(page_updates)
    page_updates.map { |pages| pages[pages.size / 2] }.sum
  end
end

Solution.new(rules, page_updates).call
