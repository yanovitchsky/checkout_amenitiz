import ReactOnRails from 'react-on-rails';

import Main from '../bundles/Pages/components/Main.jsx';

import  "../application.css"

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Main,
});
