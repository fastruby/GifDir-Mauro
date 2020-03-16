# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gif, type: :model do
  context 'without an image' do
    it 'fails with a message' do
      gif = Gif.new(name: 'hello')

      expect(gif.valid?).to be_falsy
      expect(gif.errors.size).to eq(1)
      expect(gif.errors[:img]).to eq(['is missing'])
    end
  end

  context 'with a big image' do
    let(:test_img_path) { File.open(File.join(Rails.root, 'spec/data/img.gif')) }

    it 'fails with a message' do
      gif = Gif.new(name: 'hello')
      gif.img.attach(io: test_img_path, filename: 'img.gif')

      expect(gif.valid?).to be_falsy
      expect(gif.errors.size).to eq(1)
      expect(gif.errors[:img]).to eq(["can't be more than 500K"])
    end
  end

  context 'with a small image' do
    let(:test_img_path) { File.open(File.join(Rails.root, 'spec/data/small.png')) }

    it 'is valid' do
      gif = Gif.new(name: 'hello')
      gif.img.attach(io: test_img_path, filename: 'img.gif')

      expect(gif.valid?).to be_truthy
      expect(gif.errors.size).to eq(0)
    end
  end
end
