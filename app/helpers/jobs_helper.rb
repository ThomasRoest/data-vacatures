module JobsHelper
	def job_link
		unless @job.link.blank?
		  link_to @job.link, @job.link
	  end
	end
end

# <% unless @job.link.blank? %>
# 		  <li><%= content_tag(:a, href: @job.link %></li>		
# 		  <li class="link-job-show"><%= link_to @job.link, "#{@job.link}" %></li>
# 		<% end %>