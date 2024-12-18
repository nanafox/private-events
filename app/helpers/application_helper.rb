module ApplicationHelper
  def navbar_classes_for(device_type: "desktop")
    if device_type == "desktop"
      "text-sm font-semibold text-gray-900 hover:text-indigo-900 hover:underline"
    else
      "block px-3 py-2 text-base font-semibold text-gray-900 hover:bg-gray-50"
    end
  end
end
