# frozen_string_literal: true

require_relative "fault_tolerant_requests/version"

module FaultTolerantRequests
  class Error < StandardError; end
  require_relative "fault_tolerant_requests/get_request"
  require_relative "fault_tolerant_requests/get_json_request"
end
